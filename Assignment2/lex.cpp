#include <bits/stdc++.h>
using namespace std;

string keys[6] = { "for", "if","while" ,"else" ,"int","char"};

int main(){
    ifstream infile;
    int i,j,cnt=0,decider=0,a=0,b=0;
    string str;
    char *line,*s,cur[100], prev[100];
    infile.open("input.txt");
    while (!infile.eof()){
        getline(infile,str);  cnt++;
       line=new char[str.length()+1]; strcpy(line,str.c_str()); line[str.length()]='\0';
        s=strtok(line," \t");
       // cout<<s<<endl;
        while (s!=NULL){
            for (int i=0; s[i]!='\0'; i++){
                if ((s[i]>='a' && s[i]<='z') || (s[i]>='A') && s[i]<='Z'){
                    decider=1;
                    cur[a++]=s[i];

                }
                else if (s[i]>='0' && s[i]<='9' && decider==1){
                    cur[a++]=s[i];
                   // cout<<cur<<endl;
                }
                else {
                    cur[a]='\0'; a=0; strcpy(prev,cur);

//                    if (s[i]=='('){
//                            if (strcmp(prev,keys[0].c_str())==0 || strcmp(prev,keys[1].c_str())==0)
//                                cout<< cnt<< ". "<< prev<<endl;
//                            else cout<< cnt<< ". function"<<endl;
//                        }

                        if (s[i]=='(') {
                                b=0;
                                for (int j=0; j<6; j++){
                                    if (strcmp(prev,keys[j].c_str())==0){
                                        cout<< cnt<< ". "<< prev<<endl;
                                        b=1; break;
                                    }
                                }
                                if (b==0) cout<< cnt<< "."<<cur<< endl;
                            }
                }
            }
            s=strtok(NULL, " ");
        }
    }
}
