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
package org.apache.royale.jewel
{
    COMPILE::JS
    {
	import org.apache.royale.core.WrappedHTMLElement;
	import org.apache.royale.html.util.addElementToWrapper;
    }
	import org.apache.royale.events.MouseEvent;
	import org.apache.royale.core.ISelectionModel;

	/**
	 *  The TabBar class is a List used for navigate other organized content
	 *  in a Royale Application. In HTML is represented by a <nav> tag in HTML and
	 *  It parents a list of links.
	 *  By default it uses TabBarButtonItemRenderer class to define each item.
	 *
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.4
	 */
	public class TabBar extends List
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.4
		 */
		public function TabBar()
		{
			super();

            typeNames = "jewel tabbar";

			//TabBar is always selected, so selectedIndex can't be -1, at least it will default to 0
			ISelectionModel(model).selectedIndex = 0;

			// rowHeight is not set by default, so set it to NaN
			rowHeight = NaN;

			addEventListener(MouseEvent.CLICK, internalMouseHandler);
		}

		private function internalMouseHandler(event:MouseEvent):void
		{
			COMPILE::JS
			{
				// avoid a link tries to open a new page 
				event.preventDefault();
			}
		}

		/**
		 * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
		 */
		COMPILE::JS
		override protected function createElement():WrappedHTMLElement
		{
			addElementToWrapper(this,'div');
			element.className = "content";
			positioner = document.createElement('div') as WrappedHTMLElement;
			return element;
		}

		COMPILE::JS
		private var _positioner:WrappedHTMLElement;

		COMPILE::JS
		override public function get positioner():WrappedHTMLElement
		{
			return _positioner;
		}

		COMPILE::JS
		override public function set positioner(value:WrappedHTMLElement):void
		{
			_positioner = value;
            _positioner.royale_wrapper = this;
			_positioner.appendChild(element);
		}
	}
}
