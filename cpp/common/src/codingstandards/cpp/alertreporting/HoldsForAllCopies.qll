/**
 * A module for considering whether a result occurs in all copies of the code at a given location.
 *
 * Multiple copies of an element at the same location can occur for two main reasons:
 *  1. Instantiations of a template
 *  2. Re-compilation of a file under a different context
 * This module helps ensure that a particular condition holds for all copies of a particular logical
 * element. For example, this can be used to determine whether a line of code is dead in all copies
 * of a piece of code.
 *
 * This module is parameterized by a set of _candidate_ elements in the program. For each candidate
 * element, we determine whether all other elements in the same element set that occur at the same
 * location in the program are also part of the same set, ignoring any results generated by macros.
 *
 * We do so by reporting a new type of result, `LogicalResultElement`, which represents a logical result
 * where all instances of a element at a given location are considered to be part of the same set.
 */

import cpp

/**
 * Holds if the `Element` `e` is not within a macro expansion, i.e. generated by a macro, but not
 * the outermost `Element` or `Expr` generated by the macro.
 */
predicate isNotWithinMacroExpansion(Element e) {
  not e.isInMacroExpansion()
  or
  exists(MacroInvocation mi |
    mi.getStmt() = e
    or
    mi.getExpr() = e
    or
    mi.getStmt().(ExprStmt).getExpr() = e
  |
    not exists(mi.getParentInvocation())
  )
}

/**
 * A type representing a set of Element's in the program that satisfy some condition.
 *
 * `HoldsForAllCopies<T>::LogicalResultElement` will represent an element in this set
 * iff all copies of that element satisfy the condition.
 */
signature class CandidateElementSig extends Element;

/** The super set of relevant elements. */
signature class ElementSetSig extends Element;

/**
 * A module for considering whether a result occurs in all copies of the code at a given location.
 */
module HoldsForAllCopies<CandidateElementSig CandidateElement, ElementSetSig ElementSet> {
  private predicate hasLocation(
    ElementSet s, string filepath, int startline, int startcolumn, int endline, int endcolumn
  ) {
    s.getLocation().hasLocationInfo(filepath, startline, startcolumn, endline, endcolumn)
  }

  final private class MyElement = ElementSet;

  /**
   * A `Element` that appears at the same location as a candidate element.
   */
  private class RelevantElement extends MyElement {
    CandidateElement e;

    RelevantElement() {
      exists(string filepath, int startline, int startcolumn, int endline, int endcolumn |
        hasLocation(this, filepath, startline, startcolumn, endline, endcolumn) and
        hasLocation(e, filepath, startline, startcolumn, endline, endcolumn)
      ) and
      // Not within a macro expansion, as we cannot match up instances by location in that
      // case
      isNotWithinMacroExpansion(this) and
      // Ignore catch handlers, as they occur at the same location as the catch block
      not this instanceof Handler
    }

    CandidateElement getCandidateElement() { result = e }
  }

  newtype TResultElements =
    TLogicalResultElement(
      string filepath, int startline, int startcolumn, int endline, int endcolumn
    ) {
      exists(CandidateElement s |
        // Only consider candidates where we can match up the location
        isNotWithinMacroExpansion(s) and
        hasLocation(s, filepath, startline, startcolumn, endline, endcolumn) and
        // All relevant elements that occur at the same location are candidates
        forex(RelevantElement relevantElement | s = relevantElement.getCandidateElement() |
          relevantElement instanceof CandidateElement
        )
      )
    }

  /**
   * A logical result element representing all copies of an element that occur at the same
   * location, iff they all belong to the `CandidateElement` set.
   */
  class LogicalResultElement extends TLogicalResultElement {
    predicate hasLocationInfo(
      string filepath, int startline, int startcolumn, int endline, int endcolumn
    ) {
      this = TLogicalResultElement(filepath, startline, startcolumn, endline, endcolumn)
    }

    /** Gets a copy instance of this logical result element. */
    CandidateElement getAnElementInstance() {
      exists(string filepath, int startline, int startcolumn, int endline, int endcolumn |
        this = TLogicalResultElement(filepath, startline, startcolumn, endline, endcolumn) and
        hasLocation(result, filepath, startline, startcolumn, endline, endcolumn)
      )
    }

    string toString() { result = getAnElementInstance().toString() }
  }
}
