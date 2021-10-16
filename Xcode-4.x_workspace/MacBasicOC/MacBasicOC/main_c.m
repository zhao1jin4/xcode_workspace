//
//  main_c.c
//  MacBasicOC
//
//  Created by LiZhaoJin on 13-4-26.
//  Copyright (c) 2013年 zhaojin . All rights reserved.
//

#import <Foundation/Foundation.h>
#import <wchar.h>
#import <stdlib.h>

wchar_t* convertNSStringToWChar(NSString* strName)//要free(),不能有%d ???
{
    const char  *cString;
    cString = [strName cStringUsingEncoding:NSUTF8StringEncoding];
    //char转wchar_t
    setlocale(LC_CTYPE, "UTF-8");
    int iLength = mbstowcs(NULL, cString, 0);
    wchar_t *stTmp = (wchar_t*)malloc((iLength +1)*2);
    memset(stTmp, 0, (iLength +1)*2);
    mbstowcs(stTmp, cString, iLength +1);
    stTmp[iLength] = L'\0';
    return stTmp;
}
NSString *converWCharToNSString(const wchar_t*  wchar)
{
    //wchar_t在mac intel下就是UTF-32LE，所以
    int len=(wcslen(wchar)+1)*4;//12,即3*4=12
    NSString *str = [[NSString alloc] initWithBytes:wchar length:len encoding:NSUTF32LittleEndianStringEncoding];
    return str;
}



void log(NSString * text,...)
{
    @try {
  
    const wchar_t * cstrParams=convertNSStringToWChar(text);
    wprintf(cstrParams);//不对????
    
    wchar_t res[text.length+1];
    int index=0;
    bool isPercent=false;
    //----C 动态参数
    int count, i;
	va_list marker;
	va_start( marker, cstrParams);//信息存到va_list,表示cstrParams参数后面的做为动态参数
	
    for (i = 0; i < count; i++)
	{   
        if(cstrParams[i]==L'%' &&  i+1 < count)
        {
            const char * cstrStrParam;
            int nNumberParam;
            switch (cstrParams[i+1])
            {
                case 'd':
                    nNumberParam = va_arg( marker, int);//va_arg 是会va_list中存入按 int 顺序取
                    wprintf(L"Param %d: int type, value = %d\n", i, nNumberParam);//wprintf(L
                    
                    wchar_t num[9];
                    swprintf(num,L"%d",nNumberParam);
                    
                    wcsncpy(res+index,num,wcslen(num));
                    index+=strlen(num);//相当于append

                    isPercent=true;
                    i++;
                    break;
                /*
                case '@':
                    cstrStrParam = va_arg( marker, const wchar_t *);//char*
                    
                    wprintf(L"Param %d: string type, value = '%ls'\n", i, cstrStrParam);//%s
                    break;
                */ 
            }
               
        }

        wcsncpy(res+index,&cstrParams[i],1);
        index++;//相当于append
        res[index]=L'\0';
        wprintf(res);
   }
	va_end( marker);//释放va_list内存

    free(cstrParams);
        
        
    }
    @catch (NSException *exception) {
        NSLog(exception.description);
    }
    
}
int testarg(const wchar_t * cstrParams, ...)//chart*
{
	int count, i;
	va_list marker;
	count = wcslen(cstrParams);//strlen
	va_start( marker, cstrParams);//信息存到va_list,表示cstrParams参数后面的做为动态参数
	for (i = 0; i < count; i++)
	{
		const char * cstrStrParam;
		int nNumberParam;
		switch (cstrParams[i])
		{
            case 'I':
                nNumberParam = va_arg( marker, int);//va_arg 是会va_list中存入按 int 顺序取
                wprintf(L"Param %d: int type, value = %d\n", i, nNumberParam);//wprintf(L
                break;
            case 'S':
                cstrStrParam = va_arg( marker, const wchar_t *);//char*
                wprintf(L"Param %d: string type, value = '%ls'\n", i, cstrStrParam);//%s
                break;
		}
	}
	va_end( marker);//释放va_list内存
	return 0;
}


int main_c (int argc, const char *argv[])
{

    NSString *strName = @"OC的中文%d!"; 
    wchar_t *stTmp= convertNSStringToWChar(strName);
    wprintf(stTmp);
    wprintf(L"\n");
    free(stTmp);
    //-------
//    wchar_t *wchar = L"CPP的中文";
//    NSString *str =  converWCharToNSString(wchar);
//    NSLog(str);
    
    //---动态参数
    //testarg(L"ISI", 3,  L"3 & 4",4);//L
    //log(@"OC动态d=%d,str=%@",12,@"123");
    //log(@"OC动态d=%d",12);
    
}