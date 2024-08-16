import {Workspace} from 'blockly';
import React, {useEffect, useRef} from 'react';
import {useSelector} from 'react-redux';

import {GeneratedEffect} from './types';
import {generateAiEffectBlocksXmlFromResult} from './utils';

import moduleStyles from './ai-block-preview.module.scss';

interface AiBlockPreviewProps {
  results: GeneratedEffect;
}

/**
 * Previews the blocks generated by the AI block in Dance Party.
 */
const AiBlockPreview: React.FunctionComponent<AiBlockPreviewProps> = ({
  results,
}) => {
  const blockPreviewContainerRef = useRef<HTMLSpanElement>(null);
  const workspaceRef = useRef<Workspace | null>(null);
  const isRtl = useSelector((state: {isRtl: boolean}) => state.isRtl);

  // Create the workspace once the container has been rendered.
  useEffect(() => {
    if (!blockPreviewContainerRef.current) {
      return;
    }

    const xml = generateAiEffectBlocksXmlFromResult(results);
    const blocks = Blockly.utils.xml.textToDom(xml);
    workspaceRef.current = Blockly.createEmbeddedWorkspace(
      blockPreviewContainerRef.current,
      blocks,
      {rtl: isRtl}
    );

    return () => {
      workspaceRef.current?.clear();
    };
  }, [blockPreviewContainerRef, isRtl, results]);

  // Dispose of the workspace on unmount.
  useEffect(() => () => workspaceRef.current?.dispose(), []);

  return (
    <span ref={blockPreviewContainerRef} className={moduleStyles.container} />
  );
};

export default AiBlockPreview;
