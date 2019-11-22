#import <Foundation/Foundation.h>

#import "Producer.hpp"

@interface ProducerWrapper : NSObject
@property(nonatomic, readonly) NSString *id;
@property(nonatomic, readonly) NSString *localId;
@property(nonatomic, readonly) NSObject *track;
@property(nonatomic, readonly) NSObject *rtpParameters;
@property(nonatomic, readonly) NSObject *appData;
@end

@interface ProducerWrapper ()
@property (atomic, readonly, assign) mediasoupclient::Producer *producer;
@end

@implementation ProducerWrapper
@synthesize producer = _producer;

- (id)init {
    self = [super init];
    if (self) {
        //_producer = new mediasoupclient::Producer()
    }
    return self;
}

-(NSString *)getNativeId {
    return [NSString stringWithUTF8String:self.producer->GetId().c_str()];
}

-(Boolean *)isNativeClosed {
    return (Boolean *)self.producer->IsClosed();
}

-(NSString *)getNativeKind {
    return [NSString stringWithUTF8String:self.producer->GetKind().c_str()];
}

-(NSObject *)getNativeTrack {
    return (NSObject *)CFBridgingRelease(self.producer->GetTrack());
}

-(Boolean *)isNativePaused {
    return (Boolean *)self.producer->IsPaused();
}

-(uint8_t)getNativeMaxSpatialLayer {
    return self.producer->GetMaxSpatialLayer();
}

-(NSString *)getNativeAppData {
    std::string appDataString = self.producer->GetAppData().dump();
    return [NSString stringWithUTF8String:appDataString.c_str()];
}

-(NSString *)getNativeRtpParameters {
    std::string rtpParametersString = self.producer->GetRtpParameters().dump();
    return [NSString stringWithUTF8String:rtpParametersString.c_str()];
}

-(NSString *)getNativeStats {
    std::string statsString = self.producer->GetStats().dump();
    return [NSString stringWithUTF8String:statsString.c_str()];
}

-(void)nativeResume {
    self.producer->Resume();
}

-(void)setNativeMaxSpatialLayer:(uint8_t)layer {
    self.producer->SetMaxSpatialLayer(layer);
}

-(void)nativePause {
    self.producer->Pause();
}

-(void)nativeReplaceTrack:(NSObject *)track {
    self.producer->ReplaceTrack((webrtc::MediaStreamTrackInterface *)CFBridgingRetain(track));
}

-(void)nativeClose {
    self.producer->Close();
}

@end