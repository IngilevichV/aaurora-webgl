import { RefObject, useEffect } from 'react';

export const useEventListener = <
  T extends HTMLElement | SVGElement = HTMLDivElement | SVGElement
>(
  eventName: string,
  handler: (event: any) => void,
  element?: RefObject<T | undefined>,
  capture = false
) => {
  useEffect(() => {
    const targetElement: T | Window = element?.current || window;
    if (!(targetElement && targetElement.addEventListener)) {
      return;
    }
    targetElement.addEventListener(eventName, handler, capture);

    return () => {
      targetElement?.removeEventListener(eventName, handler, capture);
    };
  }, [eventName, element, handler, capture]);
};
