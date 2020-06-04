

%hook XMNowPlayingTrackSampleToastView


- (id)initWithFrame:(struct CGRect)arg1 {
	return nil;
}

%end

%hook XMSoundPatchBaseView 

- (id)initWithFrame:(struct CGRect)arg1 {
	return nil;
}


%end

%hook XMAdAnimationViewTwo 

- (id)initWithFrame:(struct CGRect)arg1 {
	return nil;
}

%end

%hook XMAdSoundPatchReminder 

- (id)hitTest:(struct CGPoint)arg1 withEvent:(id)arg2 {
	return nil;
}

- (id)init {
	return nil;
}

%end