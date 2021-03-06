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
package org.apache.royale.html.beads
{
	import org.apache.royale.core.IBead;
	import org.apache.royale.core.IDataProviderModel;
	import org.apache.royale.core.IItemRendererClassFactory;
	import org.apache.royale.core.IItemRendererInitializer;
	import org.apache.royale.core.IItemRendererOwnerView;
	import org.apache.royale.core.IStrand;
	import org.apache.royale.events.Event;
	import org.apache.royale.events.EventDispatcher;
	import org.apache.royale.events.IEventDispatcher;
	import org.apache.royale.utils.loadBeadFromValuesManager;

    /**
     *  The DataItemRendererFactoryBase class is a base class
     *  for IDataProviderItemRendererMapper implementations.
     *  
     *  @langversion 3.0
     *  @playerversion Flash 10.2
     *  @playerversion AIR 2.6
     *  @productversion Royale 0.8
     */
	public class ItemRendererFactoryBase extends EventDispatcher implements IBead
	{
        /**
         *  Constructor.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.8
         */
		public function ItemRendererFactoryBase(target:Object=null)
		{
			super(target);
		}

		protected var dataProviderModel:IDataProviderModel;
		//protected var dataFieldProvider:DataFieldProviderBead;
		
		protected var _strand:IStrand;
		
        /**
         *  @copy org.apache.royale.core.IBead#strand
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.8
		 *  @royaleignorecoercion org.apache.royale.events.IEventDispatcher
         */
		public function set strand(value:IStrand):void
		{
			_strand = value; 
			IEventDispatcher(value).addEventListener("initComplete", finishSetup);
		}
		
		/**
		 * @private
		 * @royaleignorecoercion org.apache.royale.core.IDataProviderModel
		 * @royaleignorecoercion org.apache.royale.core.IItemRendererClassFactory
		 * @royaleignorecoercion org.apache.royale.html.beads.DataFieldProviderBead
		 */
		protected function finishSetup(event:Event):void
		{			
			IEventDispatcher(_strand).removeEventListener("initComplete", finishSetup);
			dataProviderModel = _strand.getBeadByType(IDataProviderModel) as IDataProviderModel;
			dataProviderModel.addEventListener("dataProviderChanged", dataProviderChangeHandler);

			// if the host component inherits from DataContainerBase, the itemRendererClassFactory will 
			// already have been loaded by DataContainerBase.addedToParent function.
			if(!_itemRendererFactory)
    			_itemRendererFactory = loadBeadFromValuesManager(IItemRendererClassFactory, "iItemRendererClassFactory", _strand) as IItemRendererClassFactory;				

            dataProviderChangeHandler(null);
		}
		
		private var _itemRendererFactory:IItemRendererClassFactory;
		
        /**
         *  The org.apache.royale.core.IItemRendererClassFactory used 
         *  to generate instances of item renderers.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.8
		 *  @royaleignorecoercion org.apache.royale.core.IItemRendererClassFactory
         */
		public function get itemRendererFactory():IItemRendererClassFactory
		{
			if(!_itemRendererFactory)
    			_itemRendererFactory = loadBeadFromValuesManager(IItemRendererClassFactory, "iItemRendererClassFactory", _strand) as IItemRendererClassFactory;
			
			return _itemRendererFactory;
		}
		
        /**
         *  @private
         */
		public function set itemRendererFactory(value:IItemRendererClassFactory):void
		{
			_itemRendererFactory = value;
		}
		
        private var _itemRendererInitializer:IItemRendererInitializer;
        
        /**
         *  The org.apache.royale.core.IItemRendererInitializer used 
         *  to initialize instances of item renderers.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.8
         *  @royaleignorecoercion org.apache.royale.core.IItemRendererInitializer
         */
        public function get itemRendererInitializer():IItemRendererInitializer
        {
            if(!_itemRendererInitializer)
                _itemRendererInitializer = loadBeadFromValuesManager(IItemRendererInitializer, "iItemRendererInitializer", _strand) as IItemRendererInitializer;
            
            return _itemRendererInitializer;
        }
        
        /**
         *  @private
         */
        public function set itemRendererInitializer(value:IItemRendererInitializer):void
        {
            _itemRendererInitializer = value;
        }
                
        /**
         *  This Factory deletes all renderers, and generates a renderer
         *  for every data provider item.
         *  
         *  @langversion 3.0
         *  @playerversion Flash 10.2
         *  @playerversion AIR 2.6
         *  @productversion Royale 0.8
		 *  @royaleignorecoercion Array
         *  @royaleignorecoercion org.apache.royale.core.IStrandWithModelView
         *  @royaleignorecoercion org.apache.royale.html.beads.IListView
		 *  @royaleignorecoercion org.apache.royale.core.IListPresentationModel
		 *  @royaleignorecoercion org.apache.royale.core.UIBase
		 *  @royaleignorecoercion org.apache.royale.core.IItemRenderer
		 *  @royaleignorecoercion org.apache.royale.core.IIndexedItemRenderer
		 *  @royaleignorecoercion org.apache.royale.core.IIndexedItemRendererInitializer
		 *  @royaleignorecoercion org.apache.royale.html.supportClasses.DataItemRenderer
		 *  @royaleignorecoercion org.apache.royale.events.IEventDispatcher
         */		
		protected function dataProviderChangeHandler(event:Event):void
		{
		}
        
        protected function removeAllItemRenderers(dataGroup:IItemRendererOwnerView):void
        {
            dataGroup.removeAllItemRenderers();            
        }
        
        protected function get dataProviderLength():int
        {
            return 0;
        }
        
        protected function getItemAt(i:int):Object
        {
            return null;
        }

	}
}
