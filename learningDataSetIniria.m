global opts;
global detector;

%% extract training and testing images and ground truth
cd(fileparts(which('acfDemoInria.m'))); dataDir='../../data/Inria/';
for s=1:2, pth=dbInfo('InriaTest');
  if(s==1), set='00'; type='train'; else set='01'; type='test'; end
  if(exist([dataDir type '/posGt'],'dir')), continue; end
  seqIo([pth '/videos/set' set '/V000'],'toImgs',[dataDir type '/pos']);
  seqIo([pth '/videos/set' set '/V001'],'toImgs',[dataDir type '/neg']);
  V=vbb('vbbLoad',[pth '/annotations/set' set '/V000']);
  vbb('vbbToFiles',V,[dataDir type '/posGt']);
end

%% set up opts for training detector (see acfTrain)
opts=acfTrain(); opts.modelDs=[100 41]; opts.modelDsPad=[128 64];
opts.posGtDir=[dataDir 'train/posGt']; opts.nWeak=[32 128 512 2048];
opts.posImgDir=[dataDir 'train/pos']; opts.pJitter=struct('flip',1);
opts.negImgDir=[dataDir 'train/neg']; opts.pBoost.pTree.fracFtrs=1/16;
opts.pLoad={'squarify',{3,.41}}; opts.name='models/AcfInria';

%% optionally switch to LDCF version of detector (see acfTrain)
if( 0 )
  opts.filters=[5 4]; opts.pJitter=struct('flip',1,'nTrn',3,'mTrn',1);
  opts.pBoost.pTree.maxDepth=3; opts.pBoost.discrete=0; opts.seed=2;
  opts.pPyramid.pChns.shrink=2; opts.name='models/LdcfInria';
end

%% train detector (see acfTrain)
detector = acfTrain( opts );

%% modify detector (see acfModify)
pModify=struct('cascThr',-1,'cascCal',.01);
detector=acfModify(detector,pModify);