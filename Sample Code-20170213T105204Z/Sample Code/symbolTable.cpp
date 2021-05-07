#include <iostream>
#include <bits/stdc++.h>
#include <stdio.h>
#include <list>
#include <string.h>
#include <fstream>
#include <vector>
#include <cstring>
using namespace std;

#define MOD 101
#define SIZE 101

int hash_func(string str)
{
    int i;
    int hash=0;
    for(i=0; i<str.length(); i++)
    {
        hash += str[i]^i * 27;
        hash %= MOD;
    }
    return hash;
}

class symbolInfo
{
public:
    string name;
    string type;
    symbolInfo(){}
   symbolInfo(string n, string t)
    {
        name = n;
        type = t;
    }

};

class symbolTable
{
public:
    vector <symbolInfo > stable[SIZE];
    symbolInfo symin;

     void print(){
    vector<symbolInfo>:: iterator it;

                for(int i=0;i<SIZE;i++){
                      if(stable[i].size() == 0)continue;
                  cout<<"["<<i<<"] -> "<<endl;
               for(it=stable[i].begin();it!=stable[i].end();it++){

                    cout<<"\t<"<<it->name <<","<<it->type<<">"<<endl;
                    }
                    cout<<endl;
                }}

int look_up(string n)
    {
          int f=0;
        vector<symbolInfo>::iterator it;
        for(int i=0;i<SIZE;i++){
        for(it= stable[i].begin();it!=stable[i].end();it++){

            if( n== it->name)
            {
                f++;
                cout<<"<"<<n<<","<<it->type<<">"<<"found at position "<< hash_func(n)<< " , "<< stable[hash_func(n)].size()-1<<"\n"<<endl;
               // break;
               return 1;
            }
     }
        }
        if(f==0)
        {
            cout<<n << " not found \n"<<endl;
            return 0;
        }

    }


    void inset(string n, string t)

    {
        if(look_up(n))return;

        else{
         stable[hash_func(n)].push_back(symbolInfo(n,t));

           cout<<"<"<<n<<","<<t<<">"<<"is at position "<< hash_func(n)<< " , "<< stable[hash_func(n)].size()-1<<"\n"<<endl;
        }
    }

    void delet(string n)
    {
            vector<symbolInfo>::iterator it;
            if(look_up(n))
        {
             for(int i=0;i<SIZE;i++){

        for(it= stable[i].begin();it!=stable[i].end();it++){
               if(n==it->name)
            {

                it=stable[i].erase(it);
                cout<<n <<" deleted from " <<hash_func(n)<< " , "<< stable[hash_func(n)].size()<<"\n"<<endl;
                return;

            }

        }
    }
        }
    else{
        cout<<n <<" not found!\n"<<endl;
    }
}
};




int main()
{
    symbolTable symtab;
    fstream input("input.txt");
    char token;
    string n,t;
    while(input>>token)
    {
        switch(token)
        {
            case 'I':
                printf("insert\n\n");
                input>>n>>t;
                cout<<token<<" " <<n <<" "<<t<<"\n"<<endl;
                symtab.inset(n,t);
             break;

            case 'D':

                printf("Deleted\n\n");
                input>>n;
                cout<<token<<" " <<n <<"\n"<<endl;
                symtab.delet(n);
                break;

            case 'L':
                printf("look up\n\n");
                input>>n;
                cout<<token<<" " <<n <<endl;
              symtab.look_up(n);

                break;
            case 'P':
                printf("Printed\n\n");
                cout<<token<<"\n"<<endl;
                 symtab.print();

               break;

            default:
                printf("Wrong input\n\n");
                break;

        }
    }

    return 0;
}


