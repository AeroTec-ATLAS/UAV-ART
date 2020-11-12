% Inputs
% figHandle: what is returned from calling functin figure
% fileName: name to give to the PDF saved figure
% Adapted from 
% https://www.mathworks.com/matlabcentral/answers/12987-how-to-save-a-matlab-graphic-in-a-right-size-pdf
% on the 7th October 2020

function saveFigAsPDF(figHandle, fileName)
    set(figHandle,'Units','Inches');
    pathFigPos = get(figHandle,'Position');
    set(figHandle,'PaperPositionMode','Auto','PaperUnits','Inches',...
        'PaperSize',[pathFigPos(3), pathFigPos(4)])
    print(figHandle,fileName,'-dpdf','-r0')
end

