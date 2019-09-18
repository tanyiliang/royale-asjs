////////////////////////////////////////////////////////////////////////////////
//
//  Licensed to the Apache Software Foundation (ASF) under one or more
//  contributor license agreements.  See the NOTICE file distributed with
//  this work for additional information regarding copyright ownership.
//  The ASF licenses this file to You under the Apache License, Version 2.0
//  (the "License"); you may not use this file except in compliance with
//  the License.  You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//
////////////////////////////////////////////////////////////////////////////////
package tests
{
	import org.apache.royale.test.Assert;

	public class ScopeTests
	{
		private var _value:String = "ScopeTests hello";

		[Before]
		public function before():void
		{
			Assert.assertStrictlyEquals(this._value, "ScopeTests hello",
				"Function marked with [Before] metadata called with incorrect scope.");
		}

		[After]
		public function after():void
		{
			Assert.assertStrictlyEquals(this._value, "ScopeTests hello",
				"Function marked with [After] metadata called with incorrect scope.");
		}

		[BeforeClass]
		public function beforeClass():void
		{
			Assert.assertStrictlyEquals(this._value, "ScopeTests hello",
				"Function marked with [BeforeClass] metadata called with incorrect scope.");
		}

		[AfterClass]
		public function afterClass():void
		{
			Assert.assertStrictlyEquals(this._value, "ScopeTests hello",
				"Function marked with [AfterClass] metadata called with incorrect scope.");
		}

		[Test]
		public function testScope():void
		{
			Assert.assertStrictlyEquals(this._value, "ScopeTests hello",
				"Function marked with [Test] metadata called with incorrect scope.");
		}
	}
}