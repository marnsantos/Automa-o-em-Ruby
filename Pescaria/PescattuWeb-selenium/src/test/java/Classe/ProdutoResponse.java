package Classe;

import java.util.List;


public class ProdutoResponse {


    /**
     * data : {"content":[{"createdAt":"2018-07-17T18:15:00.273Z","description":"string","enabled":true,"energeticValue":"string","imageDtoList":[{"imageId":0,"position":0,"productId":0,"url":"string"}],"name":"string","preservationFreezer":0,"preservationRefrigerator":0,"priceApp":0,"priceWholeSale":0,"productCod":"string","productId":0,"protein":"string","quantity":0,"size":"string","totalFat":"string","weight":0}],"first":true,"last":true,"number":0,"numberOfElements":0,"pageable":{"offset":0,"pageNumber":0,"pageSize":0,"paged":true,"sort":{"sorted":true,"unsorted":true},"unpaged":true},"size":0,"sort":{"sorted":true,"unsorted":true},"totalElements":0,"totalPages":0}
     * errors : ["string"]
     */

    private DataBean data;
    private List<String> errors;

    public DataBean getData() {
        return data;
    }

    public void setData(DataBean data) {
        this.data = data;
    }

    public List<String> getErrors() {
        return errors;
    }

    public void setErrors(List<String> errors) {
        this.errors = errors;
    }

    public static class DataBean {
        /**
         * content : [{"createdAt":"2018-07-17T18:15:00.273Z","description":"string","enabled":true,"energeticValue":"string","imageDtoList":[{"imageId":0,"position":0,"productId":0,"url":"string"}],"name":"string","preservationFreezer":0,"preservationRefrigerator":0,"priceApp":0,"priceWholeSale":0,"productCod":"string","productId":0,"protein":"string","quantity":0,"size":"string","totalFat":"string","weight":0}]
         * first : true
         * last : true
         * number : 0
         * numberOfElements : 0
         * pageable : {"offset":0,"pageNumber":0,"pageSize":0,"paged":true,"sort":{"sorted":true,"unsorted":true},"unpaged":true}
         * size : 0
         * sort : {"sorted":true,"unsorted":true}
         * totalElements : 0
         * totalPages : 0
         */

        private boolean first;
        private boolean last;
        private int number;
        private int numberOfElements;
        private PageableBean pageable;
        private int size;
        private SortBeanX sort;
        private int totalElements;
        private int totalPages;
        private List<ContentBean> content;

        public boolean isFirst() {
            return first;
        }

        public void setFirst(boolean first) {
            this.first = first;
        }

        public boolean isLast() {
            return last;
        }

        public void setLast(boolean last) {
            this.last = last;
        }

        public int getNumber() {
            return number;
        }

        public void setNumber(int number) {
            this.number = number;
        }

        public int getNumberOfElements() {
            return numberOfElements;
        }

        public void setNumberOfElements(int numberOfElements) {
            this.numberOfElements = numberOfElements;
        }

        public PageableBean getPageable() {
            return pageable;
        }

        public void setPageable(PageableBean pageable) {
            this.pageable = pageable;
        }

        public int getSize() {
            return size;
        }

        public void setSize(int size) {
            this.size = size;
        }

        public SortBeanX getSort() {
            return sort;
        }

        public void setSort(SortBeanX sort) {
            this.sort = sort;
        }

        public int getTotalElements() {
            return totalElements;
        }

        public void setTotalElements(int totalElements) {
            this.totalElements = totalElements;
        }

        public int getTotalPages() {
            return totalPages;
        }

        public void setTotalPages(int totalPages) {
            this.totalPages = totalPages;
        }

        public List<ContentBean> getContent() {
            return content;
        }

        public void setContent(List<ContentBean> content) {
            this.content = content;
        }

        public static class PageableBean {
            /**
             * offset : 0
             * pageNumber : 0
             * pageSize : 0
             * paged : true
             * sort : {"sorted":true,"unsorted":true}
             * unpaged : true
             */

            private int offset;
            private int pageNumber;
            private int pageSize;
            private boolean paged;
            private SortBean sort;
            private boolean unpaged;

            public int getOffset() {
                return offset;
            }

            public void setOffset(int offset) {
                this.offset = offset;
            }

            public int getPageNumber() {
                return pageNumber;
            }

            public void setPageNumber(int pageNumber) {
                this.pageNumber = pageNumber;
            }

            public int getPageSize() {
                return pageSize;
            }

            public void setPageSize(int pageSize) {
                this.pageSize = pageSize;
            }

            public boolean isPaged() {
                return paged;
            }

            public void setPaged(boolean paged) {
                this.paged = paged;
            }

            public SortBean getSort() {
                return sort;
            }

            public void setSort(SortBean sort) {
                this.sort = sort;
            }

            public boolean isUnpaged() {
                return unpaged;
            }

            public void setUnpaged(boolean unpaged) {
                this.unpaged = unpaged;
            }

            public static class SortBean {
                /**
                 * sorted : true
                 * unsorted : true
                 */

                private boolean sorted;
                private boolean unsorted;

                public boolean isSorted() {
                    return sorted;
                }

                public void setSorted(boolean sorted) {
                    this.sorted = sorted;
                }

                public boolean isUnsorted() {
                    return unsorted;
                }

                public void setUnsorted(boolean unsorted) {
                    this.unsorted = unsorted;
                }
            }
        }

        public static class SortBeanX {
            /**
             * sorted : true
             * unsorted : true
             */

            private boolean sorted;
            private boolean unsorted;

            public boolean isSorted() {
                return sorted;
            }

            public void setSorted(boolean sorted) {
                this.sorted = sorted;
            }

            public boolean isUnsorted() {
                return unsorted;
            }

            public void setUnsorted(boolean unsorted) {
                this.unsorted = unsorted;
            }
        }

        public static class ContentBean {
            /**
             * createdAt : 2018-07-17T18:15:00.273Z
             * description : string
             * enabled : true
             * energeticValue : string
             * imageDtoList : [{"imageId":0,"position":0,"productId":0,"url":"string"}]
             * name : string
             * preservationFreezer : 0
             * preservationRefrigerator : 0
             * priceApp : 0
             * priceWholeSale : 0
             * productCod : string
             * productId : 0
             * protein : string
             * quantity : 0
             * size : string
             * totalFat : string
             * weight : 0
             */

            private String createdAt;
            private String description;
            private boolean enabled;
            private String energeticValue;
            private String name;
            private int preservationFreezer;
            private int preservationRefrigerator;
            private float priceApp;
            private int priceWholeSale;
            private String productCod;
            private int productId;
            private String protein;
            private int quantity;
            private String size;
            private String totalFat;
            private float weight;
            private List<ImageDtoListBean> imageDtoList;

            public String getCreatedAt() {
                return createdAt;
            }

            public void setCreatedAt(String createdAt) {
                this.createdAt = createdAt;
            }

            public String getDescription() {
                return description;
            }

            public void setDescription(String description) {
                this.description = description;
            }

            public boolean isEnabled() {
                return enabled;
            }

            public void setEnabled(boolean enabled) {
                this.enabled = enabled;
            }

            public String getEnergeticValue() {
                return energeticValue;
            }

            public void setEnergeticValue(String energeticValue) {
                this.energeticValue = energeticValue;
            }

            public String getName() {
                return name;
            }

            public void setName(String name) {
                this.name = name;
            }

            public int getPreservationFreezer() {
                return preservationFreezer;
            }

            public void setPreservationFreezer(int preservationFreezer) {
                this.preservationFreezer = preservationFreezer;
            }

            public int getPreservationRefrigerator() {
                return preservationRefrigerator;
            }

            public void setPreservationRefrigerator(int preservationRefrigerator) {
                this.preservationRefrigerator = preservationRefrigerator;
            }

            public float getPriceApp() {
                return priceApp;
            }

            public void setPriceApp(int priceApp) {
                this.priceApp = priceApp;
            }

            public int getPriceWholeSale() {
                return priceWholeSale;
            }

            public void setPriceWholeSale(int priceWholeSale) {
                this.priceWholeSale = priceWholeSale;
            }

            public String getProductCod() {
                return productCod;
            }

            public void setProductCod(String productCod) {
                this.productCod = productCod;
            }

            public int getProductId() {
                return productId;
            }

            public void setProductId(int productId) {
                this.productId = productId;
            }

            public String getProtein() {
                return protein;
            }

            public void setProtein(String protein) {
                this.protein = protein;
            }

            public int getQuantity() {
                return quantity;
            }

            public void setQuantity(int quantity) {
                this.quantity = quantity;
            }

            public String getSize() {
                return size;
            }

            public void setSize(String size) {
                this.size = size;
            }

            public String getTotalFat() {
                return totalFat;
            }

            public void setTotalFat(String totalFat) {
                this.totalFat = totalFat;
            }

            public float getWeight() {
                return weight;
            }

            public void setWeight(int weight) {
                this.weight = weight;
            }

            public List<ImageDtoListBean> getImageDtoList() {
                return imageDtoList;
            }

            public void setImageDtoList(List<ImageDtoListBean> imageDtoList) {
                this.imageDtoList = imageDtoList;
            }

            public static class ImageDtoListBean {
                /**
                 * imageId : 0
                 * position : 0
                 * productId : 0
                 * url : string
                 */

                private int imageId;
                private int position;
                private int productId;
                private String url;

                public int getImageId() {
                    return imageId;
                }

                public void setImageId(int imageId) {
                    this.imageId = imageId;
                }

                public int getPosition() {
                    return position;
                }

                public void setPosition(int position) {
                    this.position = position;
                }

                public int getProductId() {
                    return productId;
                }

                public void setProductId(int productId) {
                    this.productId = productId;
                }

                public String getUrl() {
                    return url;
                }

                public void setUrl(String url) {
                    this.url = url;
                }
            }
        }
    }
}
