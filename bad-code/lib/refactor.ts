export type ServiceData = {
  line: number; // The line number, e.g. 5 for the Pakenham line.
  direction: string; // The direction, e.g. "citybound" or "outbound".
  route: string; // The route, e.g. "via-loop" or "direct".
  serviceType: string; // The service type, e.g. "metro" or "vline".
};

const clausePrefixSet = ["line-", "direction-", "route-", "service-type-"];

export function matchesClause(clause: string, service: ServiceData) {
  let [strippedClause, negated] = stripNegation(clause) as [string, boolean];
  const clausePrefix = findClausePrefix(strippedClause);

  let matches = checkValueMatch(service, clausePrefix, strippedClause);

  return handleNegation(matches, negated)
}

function stripNegation(clause: string) {
  return clause.startsWith("!") ? [clause.slice(1), true] : [clause, false];
}

function findClausePrefix(clause: string) {
  let prefix = clausePrefixSet.find((prefix) => clause.startsWith(prefix));
  
  if (prefix === undefined) {
    throw new Error(`Unrecognised clause "${clause}".`);
  }

  return prefix;
}

function checkValueMatch(service: ServiceData, prefix: string, clause: string) {
  let expectedValue = getPrefixValueMap(service)[prefix]
  let actualValue = findClauseValue(clause)

  return expectedValue === actualValue;
}

function getPrefixValueMap(service: ServiceData) {
  return {
    "line-": service.line.toFixed(),
    "direction-": service.direction,
    "route-": service.route,
    "service-type-": service.serviceType,
  }
}

function findClauseValue(clause: string) {
  // why check it has a prefix when we already know it does
  const clausePrefix = findClausePrefix(clause);
  return clause.slice(clausePrefix.length);
}

function handleNegation(matches: boolean, negated: boolean) {
  return negated ? !matches : matches;
  // if negated and matches, return false, if not negated and true, return true
}


// need to introduce negate

// Services can be filtered with a string like "line-10 direction-citybound".
// This function takes one clause from that string (e.g. "line-10") and
// information about the service, and returns true if the service passes the
// filter. Filters can also be negated, e.g. "!line-10" means "not line 10".
