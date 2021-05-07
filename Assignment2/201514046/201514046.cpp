#include<bits/stdc++.h>

#define SIZE 100

using namespace std;


ofstream outfile_key("Keyword.txt");
ofstream outfile_Identi("Identifier.txt");
ofstream outfile_Func("Function.txt");
ofstream outfile_ternary("ternamry.txt");

string tmp;
string keyword[7]={"if","while","break",  "else", "int", "char"};
string ternary[2]={"?",":"};


int k=0;





int is_ternary(string str,int line)
{
    int i=1,c=0,cnt1;

    while(i<=2){
             if(str=="?" || str==":") cnt1++;
       if(str==ternary[i-1])
       {


          cout<<line<<" . "<<str<<"...ternary "<<cnt1<<" times "<<endl;

                outfile_ternary<<line<<" . "<<str<<"...ternary"<<cnt1<<" times "<<endl;


       }
       i++;


    }
    return c;
}


int check_Space(char p)
{

    if((p>= 'a'&& p<= 'z')||(p>= 'A'&& p<= 'Z')||(p>='0' && p<='9')){


        return 0;
    }

    else return 1;
}



int check_Char(string p)
{

    if((p[0] >= 'a'&& p[0] <= 'z')||(p[0] >= 'A'&& p[0] <= 'Z')){

        return 1;
    }

    else return 0;
}



int  check_key(string str)
{

    int i=1,c=0;

    while(i<=6)
    {
        if(str==keyword[i-1])
        {
                c=i;
        }

        i++;

    }

    return c;
}



int  if_keyword(string str, int line)
{

    int i=1,c=0;

    while(i<=6)
    {

        if(str==keyword[i-1])
        {

                cout<<line<<" . "<<str<<"...Keyword "<<endl;

                outfile_key<<line<<" . "<<str<<"...Keyword "<<endl;

                if(i==5 || i== 6){

                    k=1;
                }

                 c=1;
        }

      i++;
     }

    return c;
}



void check_what(string w, string p, int line)
{

    int i = w.find("(");

    if(i!=string::npos && !check_key(p) && check_Char(p))
        {

            cout<<line<<" . "<<p<<"...Function "<<endl;

           outfile_Func<<line<<" . "<<p<<"...Function "<<endl;

            return;
        }

        else if( k==1 && i==string::npos && !check_key(p) && check_Char(p)&& p!=tmp )
            {

            tmp=p;

             cout<<line<<" . "<<p<<"...Identifier "<<endl;

           outfile_Identi<<line<<" . "<<p<<"...Identifier "<<endl;

            return;
        }

}

 int main()
 {

    char tmp[SIZE];
    ifstream input_file("input.txt");
    string strln;
    string p;
    int line=0;

    if(input_file.is_open())
    {

        while(getline(input_file,strln))

        {

            line++;
            k=0;
          int len = strln.length();
            memset(tmp, 0, sizeof(tmp));

            for(int i=0,j=0;i<len;i++)
            {

                if(check_Space(strln[i])&& !check_Space(strln[i-1]))
                   {

                   tmp[j]=' ';
                    j++;
                    tmp[j]=strln[i];
                    j++;

                    }

            else if(check_Space(strln[i-1])&& !check_Space(strln[i]))
                {
                    tmp[j]=' ';
                    j++;
                    tmp[j]=strln[i];
                    j++;

                }

                else
                {
                    tmp[j]=strln[i];
                    j++;
                }

            }

            char *tok = strtok(tmp, "\t. ';&{}+-|[]");

            while(tok)
            {

                string w;
                w.append(tok);

                if(if_keyword(w,line)==0)
               {

                    check_what(w,p,line);
                }


                is_ternary(w,line);

                p.clear();
                p.append (tok);
                tok=strtok(NULL, " \t{}+-.;&|[]");

             }
        }
    }
    return 0;
}
