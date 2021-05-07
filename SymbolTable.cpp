#include <string>
#include <vector>
#include <iostream>

using namespace std;

#define SIZE 103

class SymbolTableEntry
{
public:
    string symbol;
    string type;
    SymbolTableEntry(){}
    SymbolTableEntry(string s, string t)
    {
        symbol = s;
        type = t;
    }
};

class SymbolTable
{
public:
    vector<SymbolTableEntry*> table[SIZE];
    int hash(string s)
    {
        int key = s.at(0);
        return key%SIZE;
    }
    bool lookup(string s)
    {
        int key = hash(s);
        vector<SymbolTableEntry*>::iterator it;
        for(it = table[key].begin(); it != table[key].end(); it++){
            SymbolTableEntry* temp =  *it;
            if(temp->symbol == s)
            {
                return true;
            }
        }
        return false;
    }
    void insert(string s, string t)
    {
        if(lookup(s))return;
        int key = hash(s);
        SymbolTableEntry *temp = new SymbolTableEntry(s,t); ///
        table[key].push_back(temp);
    }
    void dump()
    {
        for(int i=0; i <SIZE; i++)
        {
            if(table[i].size() == 0)continue;
            cout<<"["<<i<<"] -> "<<endl;
            vector<SymbolTableEntry*>::iterator it;
            for(it=table[i].begin(); it !=table[i].end(); it++){
            SymbolTableEntry* temp =  *it;
            cout<<"\t<"<<temp->symbol<<","<<temp->type<<">"<<endl;
            }
        }
    }
    SymbolTableEntry * search(string s)
    {
        /*search s*/
        //write your code here

        int key = hash(s);
        vector<SymbolTableEntry*>::iterator it;
        for(it = table[key].begin(); it != table[key].end(); it++){
            SymbolTableEntry* temp =  *it;
            if(temp->symbol == s)
            {
                return temp;
            }
        }
        return 0;
    }
    void remove(string s)
    {
        /*searches the symbol table for a entry with symbol s, if found, delete that entry*/
        //write your code here
        int key = hash(s);
        vector<SymbolTableEntry*>::iterator it;
        for(it = table[key].begin(); it != table[key].end(); it++){
            SymbolTableEntry* temp =  *it;
            if(temp->symbol == s)
            {
                table[key].erase( table[key].begin() + (it-table[key].begin() ) );
            }
        }
    }
};

int main()
{
    SymbolTable st;
    st.insert("a", "ID");
    st.insert("2", "NUM");
    st.insert("(", "PAREN");
    st.insert("abc", "ID");
    st.insert("acb", "ID");
    st.dump();
    SymbolTableEntry * temp = st.search("10");
    if(temp == 0)cout<<"test 1 complete"<<endl;
    temp = st.search("a");
    if(temp != 0)cout<<"test 2 complete"<<endl;
    temp = st.search("2");
    if(temp != 0)cout<<"test 3 complete"<<endl;
    st.remove("abc");
    st.dump();
    st.remove("2");
    st.dump();
    st.remove("a");
    st.dump();
    return 0;
}
