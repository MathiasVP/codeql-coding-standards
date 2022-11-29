//** THIS FILE IS AUTOGENERATED, DO NOT MODIFY DIRECTLY.  **/
import cpp
import RuleMetadata
import codingstandards.cpp.exclusions.RuleMetadata

newtype Declarations5Query =
  TIdentifiersDeclaredInTheSameScopeNotDistinctQuery() or
  TExternalObjectOrFunctionNotDeclaredInOneFileQuery() or
  TMissingStaticSpecifierFunctionRedeclarationCQuery() or
  TMissingStaticSpecifierObjectRedeclarationCQuery() or
  TUnnecessaryExposedIdentifierDeclarationCQuery()

predicate isDeclarations5QueryMetadata(Query query, string queryId, string ruleId) {
  query =
    // `Query` instance for the `identifiersDeclaredInTheSameScopeNotDistinct` query
    Declarations5Package::identifiersDeclaredInTheSameScopeNotDistinctQuery() and
  queryId =
    // `@id` for the `identifiersDeclaredInTheSameScopeNotDistinct` query
    "c/misra/identifiers-declared-in-the-same-scope-not-distinct" and
  ruleId = "RULE-5-2"
  or
  query =
    // `Query` instance for the `externalObjectOrFunctionNotDeclaredInOneFile` query
    Declarations5Package::externalObjectOrFunctionNotDeclaredInOneFileQuery() and
  queryId =
    // `@id` for the `externalObjectOrFunctionNotDeclaredInOneFile` query
    "c/misra/external-object-or-function-not-declared-in-one-file" and
  ruleId = "RULE-8-5"
  or
  query =
    // `Query` instance for the `missingStaticSpecifierFunctionRedeclarationC` query
    Declarations5Package::missingStaticSpecifierFunctionRedeclarationCQuery() and
  queryId =
    // `@id` for the `missingStaticSpecifierFunctionRedeclarationC` query
    "c/misra/missing-static-specifier-function-redeclaration-c" and
  ruleId = "RULE-8-8"
  or
  query =
    // `Query` instance for the `missingStaticSpecifierObjectRedeclarationC` query
    Declarations5Package::missingStaticSpecifierObjectRedeclarationCQuery() and
  queryId =
    // `@id` for the `missingStaticSpecifierObjectRedeclarationC` query
    "c/misra/missing-static-specifier-object-redeclaration-c" and
  ruleId = "RULE-8-8"
  or
  query =
    // `Query` instance for the `unnecessaryExposedIdentifierDeclarationC` query
    Declarations5Package::unnecessaryExposedIdentifierDeclarationCQuery() and
  queryId =
    // `@id` for the `unnecessaryExposedIdentifierDeclarationC` query
    "c/misra/unnecessary-exposed-identifier-declaration-c" and
  ruleId = "RULE-8-9"
}

module Declarations5Package {
  Query identifiersDeclaredInTheSameScopeNotDistinctQuery() {
    //autogenerate `Query` type
    result =
      // `Query` type for `identifiersDeclaredInTheSameScopeNotDistinct` query
      TQueryC(TDeclarations5PackageQuery(TIdentifiersDeclaredInTheSameScopeNotDistinctQuery()))
  }

  Query externalObjectOrFunctionNotDeclaredInOneFileQuery() {
    //autogenerate `Query` type
    result =
      // `Query` type for `externalObjectOrFunctionNotDeclaredInOneFile` query
      TQueryC(TDeclarations5PackageQuery(TExternalObjectOrFunctionNotDeclaredInOneFileQuery()))
  }

  Query missingStaticSpecifierFunctionRedeclarationCQuery() {
    //autogenerate `Query` type
    result =
      // `Query` type for `missingStaticSpecifierFunctionRedeclarationC` query
      TQueryC(TDeclarations5PackageQuery(TMissingStaticSpecifierFunctionRedeclarationCQuery()))
  }

  Query missingStaticSpecifierObjectRedeclarationCQuery() {
    //autogenerate `Query` type
    result =
      // `Query` type for `missingStaticSpecifierObjectRedeclarationC` query
      TQueryC(TDeclarations5PackageQuery(TMissingStaticSpecifierObjectRedeclarationCQuery()))
  }

  Query unnecessaryExposedIdentifierDeclarationCQuery() {
    //autogenerate `Query` type
    result =
      // `Query` type for `unnecessaryExposedIdentifierDeclarationC` query
      TQueryC(TDeclarations5PackageQuery(TUnnecessaryExposedIdentifierDeclarationCQuery()))
  }
}
