declare function log(n: i32): void;
declare function logstr(s: string): void;

export function add(a: i32, b: i32): i32 {
  return a + b;
}

export function main(): void {
	log(42);
}

export function hello(): void {
  logstr("Hello, world!");
}