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

vector<int> varfreq;
vector<int> posvar;
vector<int> negvar;

vector<vector<int> > clauvarpos;
vector<vector<int> > clauvarneg;


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
  clauvarpos.resize(numVars+1);
  clauvarneg.resize(numVars+1);
  varfreq.resize(numVars+1, 0);
  posvar.resize(numVars+1, 0);
  negvar.resize(numVars+1, 0);
  // Read clauses
  for (uint i = 0; i < numClauses; ++i) {
    int lit;
    while (cin >> lit and lit != 0) {
        clauses[i].push_back(lit);
        varfreq[abs(lit)]++;
        if (lit > 0) {
            posvar[lit]++;
            clauvarpos[lit].push_back(i);
        }
        else {
            negvar[-lit]++;
            clauvarneg[-lit].push_back(i);
        }
    }
  }
  

//   for (uint i = 0; i < clauvarpos.size(); ++i) {
//       cout << i << ": ";
//       for (uint j = 0; j < clauvarpos[i].size(); ++j) {
//           cout << clauvarpos[i][j] << ' ';
//       }
//       cout << endl;
//   }
//   cout << endl;
//   for (uint i = 0; i < clauvarneg.size(); ++i) {
//       cout << i << ": ";
//       for (uint j = 0; j < clauvarneg[i].size(); ++j) {
//           cout << clauvarneg[i][j] << ' ';
//       }
//       cout << endl;
//   }
  
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


bool propagateGivesConflict() {
    while (indexOfNextLitToPropagate < modelStack.size()) {
        int var = modelStack[indexOfNextLitToPropagate];
        ++indexOfNextLitToPropagate;
//         cout << "var: " << var << endl;
        if (var > 0) {
//             cout << "var " << var << endl;
//             cout << clauvarneg[var].size() << endl;
            for (uint i = 0; i < clauvarneg[var].size(); ++i) {
                int clausula = clauvarneg[var][i];
                bool someLitTrue = false;
                int numUndefs = 0;
                int lastLitUndef = 0;
//                 cout << "clausulas " << clausula << endl;
                for (uint j = 0; not someLitTrue and j < clauses[clausula].size(); ++j) {
                    int val = currentValueInModel(clauses[clausula][j]);
                    if (val == TRUE) someLitTrue = true;
                    else if (val == UNDEF) {++numUndefs; lastLitUndef = clauses[clausula][j]; }
                }
                if (not someLitTrue and numUndefs == 0) return true;
                else if (not someLitTrue and numUndefs == 1) setLiteralToTrue(lastLitUndef);
            }
        }else { // var < 0
//             cout << "var " << var << endl;
            for (uint i = 0; i < clauvarpos[-var].size(); ++i) {
                int clausula = clauvarpos[-var][i];
                bool someLitTrue = false;
                int numUndefs = 0;
                int lastLitUndef = 0;
//                 cout << "clausulas " << clausula << endl;
                for (uint j = 0; not someLitTrue and j < clauses[clausula].size(); ++j) {
                    int val = currentValueInModel(clauses[clausula][j]);
                    if (val == TRUE) someLitTrue = true;
                    else if (val == UNDEF) { ++numUndefs; lastLitUndef = clauses[clausula][j];}
                }
                if (not someLitTrue and numUndefs == 0) return true;
                else if (not someLitTrue and numUndefs == 1) setLiteralToTrue(lastLitUndef);
            }
        }
    }
    return false;
}

// bool propagateGivesConflict ( ) {
//   while ( indexOfNextLitToPropagate < modelStack.size() ) {
//     ++indexOfNextLitToPropagate;
//     for (uint i = 0; i < numClauses; ++i) {
//       bool someLitTrue = false;
//       int numUndefs = 0;
//       int lastLitUndef = 0;
//       for (uint k = 0; not someLitTrue and k < clauses[i].size(); ++k){
// 	int val = currentValueInModel(clauses[i][k]);
// 	if (val == TRUE) someLitTrue = true;
// 	else if (val == UNDEF){ ++numUndefs; lastLitUndef = clauses[i][k]; }
//       }
//       if (not someLitTrue and numUndefs == 0) return true; // conflict! all lits false
//       else if (not someLitTrue and numUndefs == 1) setLiteralToTrue(lastLitUndef);	
//     }    
//   }
//   return false;
// }

//     bool someLitTrue = false;
//     int numUndefs = 0;
//     int lastLitUndef = 0;
//     int n = modelStack.size();
//     int var = modelStack[n-1];
//     uint m = clauvar[var].size();
//     for (uint i = 0; var != 0 and i < m; ++i) {
//         int clausula = clauvar[var][i];
//         for (uint j = 0; not someLitTrue and j < clauses[clausula].size(); ++j) {
//             int val = currentValueInModel(clauses[clausula][j]);
//             if (val == TRUE) someLitTrue = true;
//             else if (val == UNDEF) {
//                 ++numUndefs;
//                 lastLitUndef = clauses[clausula-1][j];
//             }
//         }
//         if (not someLitTrue and numUndefs == 0) return true; // conflict! all lits false
//         else if (not someLitTrue and numUndefs == 1) setLiteralToTrue(lastLitUndef);
//     }
//   }
//   return false;
// }


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


// Heuristic for finding the next decision literal:
int getNextDecisionLiteral(){
    
    int pos = 0;
    int max = 0;
    for (uint i = 1; i <= numVars; ++i) {
        if (model[i] == UNDEF && max < varfreq[i]) {
            max = varfreq[i];
            pos = i;
        }
    }
    if (pos != 0 && posvar[pos] < negvar[pos]) {
        pos = -pos;
    }
    return pos;
    
//   for (uint i = 1; i <= numVars; ++i) // stupid heuristic:
//     if (model[i] == UNDEF) return i;  // returns first UNDEF var, positively
//   return 0; // reurns 0 when all literals are defined
}

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
