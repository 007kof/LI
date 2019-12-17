#include <iostream>
#include <stdlib.h>
#include <algorithm>
#include <vector>
using namespace std;

#define UNDEF -1
#define TRUE 1
#define FALSE 0

uint numVars;
uint numClauses;
vector<vector<int> > clauses;
vector<int> model;
vector<int> modelStack;
uint indexOfNextLitToPropagate;
uint decisionLevel;

vector<int> PosFreqLits;
vector<int> NegFreqLits;
vector<int> FreqLits;
vector<vector<int> > PosLits;
vector<vector<int> > NegLits;

void write_lits(const vector<vector<int> > &v) {
    for (uint i = 0; i < v.size(); ++i) {
        cout << i << ": ";
        for (uint j = 0; j < v[i].size(); ++j) {
            if (j == 0) cout << v[i][0];
            else cout << ' ' << v[i][j];
        }
        cout << endl;
    }
}

void write_vector(const vector<int> &v) {
    for (uint i = 0; i < v.size(); ++i) {
        cout << i << ": " << v[i] << endl;
    }
}

void readClauses( ){
  // Skip comments
  char c = cin.get();
  while (c == 'c') {
    while (c != '\n') c = cin.get();
    c = cin.get();
  }  
  // Read "cnf numVars numClauses"
  string aux;
  cin >> aux >> numVars >> numClauses;
  clauses.resize(numClauses);
  PosLits.resize(numVars + 1);
  NegLits.resize(numVars + 1);
  PosFreqLits.resize(numVars + 1, 0);
  NegFreqLits.resize(numVars + 1, 0);
  FreqLits.resize(numVars + 1, 0);
  // Read clauses
  for (uint i = 0; i < numClauses; ++i) {
    int lit;
    while (cin >> lit and lit != 0) {
        ++FreqLits[abs(lit)];
        clauses[i].push_back(lit);
        if (lit > 0) {
            PosLits[lit].push_back(i);
            ++PosFreqLits[lit];
        }
        else {
            NegLits[-lit].push_back(i);
            ++NegFreqLits[-lit];
        }
    }
  }
//   write_lits(clauses);
//   write_lits(PosLits);
//   write_lits(NegLits);
//   write_vector(FreqLits);
}



int currentValueInModel(int lit){
  if (lit >= 0) return model[lit];
  else {
    if (model[-lit] == UNDEF) return UNDEF;
    else return 1 - model[-lit];
  }
}


void setLiteralToTrue(int lit){
  modelStack.push_back(lit);
  if (lit > 0) model[lit] = TRUE;
  else model[-lit] = FALSE;		
}


bool propagateGivesConflict ( ) {
    while ( indexOfNextLitToPropagate < modelStack.size() ) {
        int var = modelStack[indexOfNextLitToPropagate];
        ++indexOfNextLitToPropagate;
        if (var > 0) {
            for (uint i = 0; i < NegLits[var].size(); ++i) {
                int clause = NegLits[var][i];
                bool someLitTrue = false;
                int numUndefs = 0;
                int lastLitUndef = 0;
                for (uint j = 0; not someLitTrue and j < clauses[clause].size(); ++j) {
                    int val = currentValueInModel(clauses[clause][j]);
                    if (val == TRUE) someLitTrue = true;
                    else if (val == UNDEF) {
                        ++numUndefs;
                        lastLitUndef = clauses[clause][j];
                    }
                }
                if (not someLitTrue and numUndefs == 0) return true;
                else if (not someLitTrue and numUndefs == 1) setLiteralToTrue(lastLitUndef);
            }
        }
        else {
            for (uint i = 0; i < PosLits[-var].size(); ++i) {
                int clause = PosLits[-var][i];
                bool someLitTrue = false;
                int numUndefs = 0;
                int lastLitUndef = 0;
                for (uint j = 0; not someLitTrue and j < clauses[clause].size(); ++j) {
                    int val = currentValueInModel(clauses[clause][j]);
                    if (val == TRUE) someLitTrue = true;
                    else if (val == UNDEF) {
                        ++numUndefs;
                        lastLitUndef = clauses[clause][j];
                    }
                }
                if (not someLitTrue and numUndefs == 0) return true;
                else if (not someLitTrue and numUndefs == 1) setLiteralToTrue(lastLitUndef);
            }
        }
    }
    return false;
}

/*
  while ( indexOfNextLitToPropagate < modelStack.size() ) {
    ++indexOfNextLitToPropagate;
    for (uint i = 0; i < numClauses; ++i) {
      bool someLitTrue = false;
      int numUndefs = 0;
      int lastLitUndef = 0;
      for (uint k = 0; not someLitTrue and k < clauses[i].size(); ++k){
	int val = currentValueInModel(clauses[i][k]);
	if (val == TRUE) someLitTrue = true;
	else if (val == UNDEF){ ++numUndefs; lastLitUndef = clauses[i][k]; }
      }
      if (not someLitTrue and numUndefs == 0) return true; // conflict! all lits false
      else if (not someLitTrue and numUndefs == 1) setLiteralToTrue(lastLitUndef);	
    }    
  }
  return false;
}*/


void backtrack(){
  uint i = modelStack.size() -1;
  int lit = 0;
  while (modelStack[i] != 0){ // 0 is the DL mark
    lit = modelStack[i];
    model[abs(lit)] = UNDEF;
    modelStack.pop_back();
    --i;
  }
  // at this point, lit is the last decision
  modelStack.pop_back(); // remove the DL mark
  --decisionLevel;
  indexOfNextLitToPropagate = modelStack.size();
  setLiteralToTrue(-lit);  // reverse last decision
}


/*int getNextDecisionLiteral() {
    int mostFreq = 0;
    int lastLitWithMostFreq = 0;
    for (uint i = 1; i <= numVars; ++i) {
        if (model[i] == UNDEF && mostFreq < PosFreqLits[i]) {
            mostFreq = PosFreqLits[i];
            lastLitWithMostFreq = i;
        }
    }
    for (uint i = 1; i <= numVars; ++i) {
        if (model[i] == UNDEF && mostFreq < NegFreqLits[i]) {
            mostFreq = NegFreqLits[i];
            lastLitWithMostFreq = -i;
        }
    }
    return lastLitWithMostFreq;
}*/

void restart_FreqLits_counter() {
    for (uint i = 0; i < FreqLits.size(); ++i) {
        FreqLits[i] = 0;
    }
}

void recalculate_frequency() {
    for (uint i = 0; i < clauses.size(); ++i) {
        bool someLitTrue = false;
        uint j = 0;
        while (not someLitTrue and j < clauses[i].size()) {
            int val = currentValueInModel(clauses[i][j]);
            if (val == TRUE) someLitTrue = true;
            else ++FreqLits[abs(clauses[i][j])];
            ++j;
        }
    }
}

int getNextDecisionLiteral() {
    /*if (FreqLits.size() >= 250) {
        restart_FreqLits_counter();
        recalculate_frequency();
    }*/
    int mostFreq = 0;
    int lastLitWithMostFreq = 0;
    for (uint i = 1; i <= numVars; ++i) {
        if (model[i] == UNDEF && mostFreq < FreqLits[i]) {
            mostFreq = FreqLits[i];
            lastLitWithMostFreq = i;
        }
    }
    if (PosFreqLits[lastLitWithMostFreq] > NegFreqLits[lastLitWithMostFreq]) lastLitWithMostFreq = -lastLitWithMostFreq;
//     cout << "decides: " << lastLitWithMostFreq << endl;
    return lastLitWithMostFreq;
}

// Heuristic for finding the next decision literal:
/*int getNextDecisionLiteral(){
  for (uint i = 1; i <= numVars; ++i) // stupid heuristic:
    if (model[i] == UNDEF) return i;  // returns first UNDEF var, positively
  return 0; // reurns 0 when all literals are defined
}*/

void checkmodel(){
  for (uint i = 0; i < numClauses; ++i){
    bool someTrue = false;
    for (uint j = 0; not someTrue and j < clauses[i].size(); ++j)
      someTrue = (currentValueInModel(clauses[i][j]) == TRUE);
    if (not someTrue) {
      cout << "Error in model, clause is not satisfied:";
      for (uint j = 0; j < clauses[i].size(); ++j) cout << clauses[i][j] << " ";
      cout << endl;
      exit(1);
    }
  }  
}

int main(){ 
  readClauses(); // reads numVars, numClauses and clauses
  model.resize(numVars+1,UNDEF);
  indexOfNextLitToPropagate = 0;  
  decisionLevel = 0;
  
  // Take care of initial unit clauses, if any
  for (uint i = 0; i < numClauses; ++i)
    if (clauses[i].size() == 1) {
      int lit = clauses[i][0];
      int val = currentValueInModel(lit);
      if (val == FALSE) {cout << "UNSATISFIABLE" << endl; return 10;}
      else if (val == UNDEF) setLiteralToTrue(lit);
    }
  
  // DPLL algorithm
  while (true) {
    while ( propagateGivesConflict() ) {
      if ( decisionLevel == 0) { cout << "UNSATISFIABLE" << endl; return 10; }
      backtrack();
    }
    int decisionLit = getNextDecisionLiteral();
    if (decisionLit == 0) { checkmodel(); cout << "SATISFIABLE" << endl; return 20; }
    // start new decision level:
    modelStack.push_back(0);  // push mark indicating new DL
    ++indexOfNextLitToPropagate;
    ++decisionLevel;
    setLiteralToTrue(decisionLit);    // now push decisionLit on top of the mark
  }
}  
