void f1() {
L1:;

  for (int k = 0; k < 10; k++) { // COMPLIANT
    ;
  }

  for (int i = 0; i < 10; i++) { // COMPLIANT
    if (i > 5) {
      break;
    }
  }

  for (int j = 0; j < 10; j++) { // COMPLIANT
    goto L1;
  }
}

void f2() {
L1:;

  int k = 0;

  for (int i = 0; i < 10; i++) { // NON_COMPLIANT
    if (i > 5) {
      break;
    }
    if (i < 10) {
      break;
    }
    goto L1;
  }

  while (k < 10) { // COMPLIANT
    ;
  }

  while (k < 10) { // NON_COMPLIANT
    if (k > 5) {
      break;
    }
    while (k < 3) { // COMPLIANT
      goto L1;
    }
  }
}