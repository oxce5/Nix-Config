export const shorten = (str: string | null | undefined, maxLen: number, extender = "...") => {
  if (!str) return ""; // Return an empty string if str is null/undefined

  if (str.length <= maxLen) {
    return str;
  }

  return `${str.slice(0, maxLen - extender.length)}${extender}`;
};
