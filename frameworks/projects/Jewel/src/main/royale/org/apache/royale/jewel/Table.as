
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
	import org.apache.royale.events.Event;
	import org.apache.royale.jewel.beads.models.TableModel;
	
	COMPILE::JS
    {
        import org.apache.royale.core.WrappedHTMLElement;
		import org.apache.royale.html.util.addElementToWrapper;
    }
	
	[DefaultProperty("columns")]

	/**
	 *  The Table class represents an HTML <table> element.
     *  
     *  The able uses SimpleTable along with a data mapper and item renderers to generate
     *  a Table from a data source.
     *  
	 *  
     *  @toplevel
	 *  @langversion 3.0
	 *  @playerversion Flash 10.2
	 *  @playerversion AIR 2.6
	 *  @productversion Royale 0.9.3
	 */
	public class Table extends DataContainer
	{
		/**
		 *  constructor.
		 *
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.3
		 */
		public function Table()
		{
			super();
			
			typeNames = "jewel table";
		}

		/**
		 *  The list of TableColumn objects displayed by this table. 
		 *  Each column selects different data provider item properties to display.
		 *  
		 *  The default value is null.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.3
		 */
        public function get columns():Array
		{
			return TableModel(model).columns;
		}
		public function set columns(value:Array):void
		{
			TableModel(model).columns = value;
		}

		private var _fixedHeader:Boolean;
		/**
		 *  Makes the header of the table fixed so the data rows will scroll
		 *  behind it.
		 *  
		 *  The default value is false.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.3
		 */
		public function get fixedHeader():Boolean
		{
			return _fixedHeader;
		}
		public function set fixedHeader(value:Boolean):void
		{
			_fixedHeader = value;

			toggleClass("fixedHeader", _fixedHeader);
		}

		private var _tableDataHeight:Boolean;
		/**
		 *  Makes the header of the table fixed so the data rows will scroll
		 *  behind it.
		 *  
		 *  The default value is false.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.3
		 */
		public function get tableDataHeight():Boolean
		{
			return _tableDataHeight;
		}
		public function set tableDataHeight(value:Boolean):void
		{
			_tableDataHeight = value;
		}
		
		/**
		 *  A list of data items that correspond to the rows in the table.
		 *  Each table column is associated with a property of the data items to display that property in the table cells.
		 *  
		 *  The default value is null.
		 *  
		 *  @langversion 3.0
		 *  @playerversion Flash 10.2
		 *  @playerversion AIR 2.6
		 *  @productversion Royale 0.9.3
		 */
		override public function get dataProvider():Object
		{
			return TableModel(model).dataProvider;
		}
		override public function set dataProvider(value:Object):void
		{
			TableModel(model).dataProvider = value;
		}
		
		override public function addedToParent():void
		{
			super.addedToParent();
			
			dispatchEvent( new Event("tableComplete") );
		}

		/**
         * @royaleignorecoercion org.apache.royale.core.WrappedHTMLElement
         */
        COMPILE::JS
        override protected function createElement():WrappedHTMLElement
        {
            return addElementToWrapper(this,'table');
        }
    }
}