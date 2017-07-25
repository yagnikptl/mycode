
#import "CustomURLConnection.h"
#import "JSONKit.h"
@implementation CustomURLConnection

@synthesize delegate,tag;
@synthesize senderObj;
#pragma mark
#pragma mark Init Method

-(CustomURLConnection *)initURLConnectionWithRequest:(NSURLRequest *)request withDelegate:(id<CustomURLConnectionDelegate>)senderDelegate withTag:(NSInteger)apiTag andLoader:(BOOL)loader
{
    self=[super init];
    if (self)
    {
        if (requestCount == 0) {
        //   [GLOBAL stopLoadingInView:[APPDELEGATE window]];
        }
        
        if (loader) {
         //   [GLOBAL startLoadingInView:[APPDELEGATE window] withStyle:UIActivityIndicatorViewStyleWhiteLarge];
        }
        
        requestCount ++;

        self.delegate = senderDelegate;

        self.tag=apiTag;
        urlConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
        [urlConnection start];
    }
    return self;
}

-(CustomURLConnection *)initURLConnectionWithRequest:(NSURLRequest *)request withDelegate:(id<CustomURLConnectionDelegate>)senderDelegate withTag:(NSInteger)apiTag withRefObj:(NSObject *)obj andLoader:(BOOL)loader
{
    
    self=[super init];
    if (self)
    {
        if (requestCount == 0) {
           // [GLOBAL stopLoadingInView:[APPDELEGATE window]];
        }
        
        if (loader) {
            //[GLOBAL startLoadingInView:[APPDELEGATE window] withStyle:UIActivityIndicatorViewStyleWhiteLarge];
        }
        
        requestCount ++;
        
        self.delegate = senderDelegate;
        
        self.tag=apiTag;
        senderObj = obj;
        urlConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
        [urlConnection start];
    }
    return self;
}

-(CustomURLConnection *)initURLConnectionWithRequest:(NSURLRequest *)request withDelegate:(id<CustomURLConnectionDelegate>)senderDelegate withTag:(NSInteger)apiTag withChatMessageId:(NSString *)chatMessageId andLoader:(BOOL)loader
{
    
    self=[super init];
    if (self)
    {
        if (requestCount == 0) {
            //[GLOBAL stopLoadingInView:[APPDELEGATE window]];
        }
        
        if (loader) {
            //[GLOBAL startLoadingInView:[APPDELEGATE window] withStyle:UIActivityIndicatorViewStyleWhiteLarge];
        }
        
        requestCount ++;

        self.delegate = senderDelegate;

        self.tag=apiTag;
        chatObjectId = chatMessageId;
        urlConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
        [urlConnection start];
    }
    return self;
}

-(CustomURLConnection *)initURLConnectionWithURL:(NSURL *)url withDelegate:(id<CustomURLConnectionDelegate>)senderDelegate andParameters:(NSDictionary *)paramDic andTag:(NSInteger)Ctag andLoader:(BOOL)loader
{
    self=[super init];
    
    //My code
    if (self)
    {
        //My code
        
        if (requestCount == 0) {
           // [GLOBAL stopLoadingInView:[APPDELEGATE window]];
        }
        
        if (loader) {
           // [GLOBAL startLoadingInView:[APPDELEGATE window] withStyle:UIActivityIndicatorViewStyleWhiteLarge];
        }
        
        requestCount ++;

        //set Tag
        self.tag=Ctag;
        
        self.delegate = senderDelegate;

        //Create Request
        NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url];
        [request setTimeoutInterval:60.0];
        
        //Request Method
        [request setHTTPMethod:@"POST"];
        
        //Boundry and ContentType
        NSString *boundary=@"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        //Request Data
        NSMutableData *bodyData=[[NSMutableData alloc]init];
    
        //Retrieve All Keys
        NSArray *paramKeysArray=[paramDic allKeys];
        
        //Set All the Parameters
        for (int i=0; i<[paramKeysArray count]; i++)
        {
          //  if ([[paramDic objectForKey:[paramKeysArray objectAtIndex:i]] isKindOfClass:[UIImage class]])
            {
                //If There is an Image
               // UIImage *image=[paramDic objectForKey:[paramKeysArray objectAtIndex:i]];
               // [self setName:[paramKeysArray objectAtIndex:i] withFileName:@"Photo.jpeg" withValue:UIImagePNGRepresentation(image) onBody:bodyData];
            }
           // else
            {
                //If There is No Image
                [self setName:[paramKeysArray objectAtIndex:i] withValue:[paramDic objectForKey:[paramKeysArray objectAtIndex:i]] onBody:bodyData];
            }
        }
        //Set Request Data
        [request setHTTPBody:bodyData];
        
        //Start Connection
        urlConnection=[[NSURLConnection alloc]initWithRequest:request delegate:self];
        [urlConnection start];
    }
    //===========
    return self;
}

int requestCount = 0;

#pragma mark - Requests Handeling
-(CustomURLConnection *)initWithURLByPost:(NSString *)url PostString:(NSString *)postString withMethod:(NSString *)method withDelegate:(id<CustomURLConnectionDelegate>)senderDelegate isPostJson:(BOOL)isJson withTag:(int)apiTag withLoader:(BOOL)loader
{
    
    @synchronized(self) {
        if (requestCount == 0) {
           // [GLOBAL stopLoadingInView:[APPDELEGATE window]];
        }
        
        if (loader) {
           // [GLOBAL startLoadingInView:[APPDELEGATE window] withStyle:UIActivityIndicatorViewStyleWhiteLarge];
        }
        
        requestCount ++;
        delegate = senderDelegate;
        tag = apiTag;
        NSData *postData = [postString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] init];
        [theRequest setURL:[NSURL URLWithString:url]];
        [theRequest setHTTPMethod:method];
        [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [theRequest setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]] forHTTPHeaderField:@"Content-Length"];
        [theRequest setHTTPBody: postData];
        [theRequest setTimeoutInterval:60.0];
        
        if (apiTag == TAG_ShareActivity)
        {
            [theRequest setTimeoutInterval: 5 * 60.0];
        }
        
        urlConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
//        if (urlConnection) {
//            receivedData = [NSMutableData data];
//        }
    }
    return self;
}

#pragma mark - Requests Handeling
-(CustomURLConnection *)initWithURLByPost:(NSString *)url PostString:(NSString *)postString withMethod:(NSString *)method withDelegate:(id<CustomURLConnectionDelegate>)senderDelegate isPostJson:(BOOL)isJson withTag:(int)apiTag withChatMessageId:(NSString *)chatMessageId withLoader:(BOOL)loader
{
    
    @synchronized(self) {
        if (requestCount == 0) {
          //  [GLOBAL stopLoadingInView:[APPDELEGATE window]];
        }
        
        if (loader) {
            //[GLOBAL startLoadingInView:[APPDELEGATE window] withStyle:UIActivityIndicatorViewStyleWhiteLarge];
        }
        
        requestCount ++;
        delegate = senderDelegate;
        tag = apiTag;
        chatObjectId = chatMessageId;
        NSData *postData = [postString dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSMutableURLRequest *theRequest = [[NSMutableURLRequest alloc] init];
        [theRequest setURL:[NSURL URLWithString:url]];
        [theRequest setHTTPMethod:method];
        [theRequest setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [theRequest setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[postData length]] forHTTPHeaderField:@"Content-Length"];
        [theRequest setHTTPBody: postData];
        [theRequest setTimeoutInterval:60.0];
        urlConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
//        if (urlConnection) {
//            receivedData = [NSMutableData data];
//        }
    }
    return self;
}

#pragma mark
#pragma mark Nsurlconnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    receivedData = [[NSMutableData alloc] init];
//    [receivedData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [receivedData appendData:data];
   
}

- (void)connection:(NSURLConnection *)connection   didSendBodyData:(NSInteger)bytesWritten
 totalBytesWritten:(NSInteger)totalBytesWritten
totalBytesExpectedToWrite:(NSInteger)totalBytesExpectedToWrite {
    if (delegate) {
        if ([self.delegate respondsToSelector:@selector(bytesReturn:expectedTotalBytes:withTag:)]) {
            [self.delegate bytesReturn:totalBytesWritten expectedTotalBytes:totalBytesExpectedToWrite withTag:(int)tag];
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    if (delegate) {
        if([delegate respondsToSelector:@selector(requestFailed:withError:withTag:)]) {
            requestCount --;
            if (requestCount == 0) {
              //  [GLOBAL stopLoadingInView:[APPDELEGATE window]];
            }
            NSString *strError = [error localizedDescription];
            [self.delegate requestFailed:self withError:strError withTag:tag];
        }
    }
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error = nil;
    
    JSONDecoder *jsonKitDecoder = [JSONDecoder decoderWithParseOptions:JKParseOptionValidFlags];
    
    NSDictionary *dictionary;
    if ([[jsonKitDecoder objectWithData:receivedData] valueForKey:@"d"]) {
        
        NSString *str = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];

        dictionary = [[[jsonKitDecoder objectWithData:receivedData] valueForKey:@"d"] objectFromJSONString];
       // dictionary = [dictionary dictionaryByReplacingNullsWithBlanks];
    } else {
//        dictionary = [[jsonKitDecoder objectWithData:receivedData] objectFromJSONString];
//        dictionary = [dictionary dictionaryByReplacingNullsWithBlanks];
        
        NSString *str = [[NSString alloc] initWithData:receivedData encoding:NSUTF8StringEncoding];
        
        dictionary = [NSJSONSerialization JSONObjectWithData:receivedData options:kNilOptions | NSJSONReadingAllowFragments |NSJSONReadingMutableContainers error:&error];
        //dictionary = [dictionary dictionaryByReplacingNullsWithBlanks];
    }


    if(delegate) {

        requestCount --;
        if (requestCount == 0) {
            //[GLOBAL stopLoadingInView:[APPDELEGATE window]];
        }

        if (senderObj)
        {
            
            if (error)
            {
//                [GLOBAL displatToast:[NSString stringWithFormat:@"%@",error.localizedDescription]];
                if([delegate respondsToSelector:@selector(requestFinished:withResult:withTag:withObj:)])
                {
                    [self.delegate requestFinished:self withResult:dictionary withTag:tag withObj:senderObj];
                }
            }
            else
            {
                if([delegate respondsToSelector:@selector(requestFinished:withResult:withTag:withObj:)]) {
                    [self.delegate requestFinished:self withResult:dictionary withTag:tag withObj:senderObj];
                }
            }
            self.delegate = nil;
            
        }
        else if (chatObjectId)
        {
            
            if (error)
            {
//                [GLOBAL displatToast:[NSString stringWithFormat:@"%@",error.localizedDescription]];
                if([delegate respondsToSelector:@selector(requestFinished:withResult:withTag:withChatMessageId:)]) {
                    [self.delegate requestFinished:self withResult:dictionary withTag:tag withChatMessageId:chatObjectId];
                }
            }
            else
            {
                if([delegate respondsToSelector:@selector(requestFinished:withResult:withTag:withChatMessageId:)]) {
                    [self.delegate requestFinished:self withResult:dictionary withTag:tag withChatMessageId:chatObjectId];
                }
            }
            self.delegate = nil;

        }
        else
        {
            
            if (error)
            {
//                [GLOBAL displatToast:[NSString stringWithFormat:@"%@",error.localizedDescription]];
                if([delegate respondsToSelector:@selector(requestFinished:withResult:withTag:)]) {
                    [self.delegate requestFinished:self withResult:dictionary withTag:tag];
                }
            }
            else
            {
                if([delegate respondsToSelector:@selector(requestFinished:withResult:withTag:)]) {
                    [self.delegate requestFinished:self withResult:dictionary withTag:tag];
                }
            }
            self.delegate = nil;
            
        }

    }
    
}

#pragma mark
#pragma mark Set Parameter Method
-(void)setName:(NSString *)name withValue:(NSString *)value onBody:(NSMutableData *)body
{
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",name] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[value dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
}
-(void)setName:(NSString *)name withFileName:(NSString *)fileName withValue:(NSData *)data onBody:(NSMutableData *)body
{
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    [body appendData:[[NSString stringWithFormat:@"--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\";filename=\"%@\"\r\n",name,fileName] dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:[@"Content-Type:application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [body appendData:data];
    [body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
}

@end
