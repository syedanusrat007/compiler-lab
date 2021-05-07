#include<bits/stdc++.h>
#define SIZE 100
using namespace std;

//ofstream outfile("output2.txt");

ofstream KeyWord("KeyWord.txt");
ofstream Identifier("Identifier.txt");
ofstream Function("Function.txt");
ofstream Relop("Relop.txt");
string temp, key[7]={"if","while","break",  "else", "int", "char"};
string relop[6]={"==","!=","<=",">=", "<",">"};

int kf=0;

int  is_Relop(string s, int counter)
{


    //cout<<"Function Called!!!!!!!!!!   "<<s<<endl;
    int i=1, ch=0;
    while(i<=6)
    {
        if(s==relop[i-1])
        {
                cout<<s<<"\t\t\tRelop "<<counter<<endl;
                Relop<<s<<" "<<counter<<endl;
        }

        i++;

    }
    return ch;
}
int  is_key(string s, int counter)
{


    //cout<<"Function Called!!!!!!!!!!   "<<s<<endl;
    int i=1, ch=0;
    while(i<=6)
    {
        if(s==key[i-1])
        {
                cout<<s<<"\t\t\tKeyword "<<counter<<endl;
                KeyWord<<s<<" "<<counter<<endl;

                if(i==5 || i== 6)
                    kf=1;

                ch=1;
        }

        i++;

    }
    return ch;

}



int  iskey(string s)
{

    int i=1, ch=0;
    while(i<=6)
    {
        if(s==key[i-1])
        {
                ch=i;
        }

        i++;

    }
    return ch;


}

int isChar(string pw)
{
    if((pw[0] >= 'a'&& pw[0] <= 'z')||(pw[0] >= 'A'&& pw[0] <= 'Z'))
        return 1;
    else return 0;
}

int isSpl(char pw)
{
    if((pw>= 'a'&& pw<= 'z')||(pw>= 'A'&& pw<= 'Z')||(pw>='0' && pw<='9'))
        return 0;
    else return 1;
}

void is_what(string word, string pw, int counter){
    int i = word.find("(");
    if(i!=string::npos && !iskey(pw) && isChar(pw)){
            cout<<pw<<"\t\tFunction "<<counter<<endl;
            Function<<pw<<" "<<counter<<endl;
            return;
        }
        else if( kf==1 && i==string::npos && !iskey(pw) && isChar(pw)&& pw!=temp ){
            temp=pw;
            cout<<pw <<"\tIdentifier "<<counter<< endl;
            Identifier<<pw<<" "<<counter<<endl;
            return;
        }
}

 int main(){
    char temp[SIZE];
    ifstream infile("input.txt");
    string ln,pw;
    int counter=0;
    if(infile.is_open())
    {
        while(getline(infile,ln))
        {
            counter++;
            kf=0;
          int l = ln.length();
            memset(temp, 0, sizeof(temp));
            for(int i=0,j=0; i<l;i++){
                if(isSpl(ln[i])&& !isSpl(ln[i-1]))
                   {
                   temp[j]=' ';
                    j++;
                    temp[j]=ln[i];
                    j++;
                    //cout<<temp<<endl;
                 }


                else if(isSpl(ln[i-1])&& !isSpl(ln[i])){
                    temp[j]=' ';
                    j++;
                    temp[j]=ln[i];
                    j++;
                }
                else{
                    temp[j]=ln[i];
                    j++;
                }}
            char *c = strtok(temp, "\t., ';&{}?+-|[]");
            while(c)
            {
               // cout<<c<<" "<<counter<<endl;
                string word;
                word.append(c);
                //cout<<"word"<<word<<" "<<counter<<endl;
                if(is_key(word,counter)==0){
                    is_what(word,pw,counter);
                }
                is_Relop(word, counter);

                pw.clear();
                pw.append (c);
                c=strtok(NULL, " \t{},+-.?;&|[]");


            }
        }
    }
    return 0;
}
