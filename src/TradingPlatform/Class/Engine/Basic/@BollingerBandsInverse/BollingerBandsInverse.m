
classdef BollingerBandsInverse < BollingerBands
    
    
    %% Public class methods
    methods (Access = public)
        
        
        %% Constructor
        function te = BollingerBandsInverse(fts, mode, samples, k)
            
            if ~exist('mode','var'); mode = Default.Mode; end
            if ~exist('samples','var'); samples = Default.Samples; end
            if ~exist('k','var'); k = Default.K; end
            
            te = te@BollingerBands(fts, mode, samples, k);
            
        end
        
        
        %% Methods that must be reimplemented in subclasses
        
        signal = computeSignal(te)
        
        
    end
    
    
    methods (Access = public, Static)
        
        te = optimum(fts, modeDomain, samplesDomain, KDomain)
        
    end
    
    
end
