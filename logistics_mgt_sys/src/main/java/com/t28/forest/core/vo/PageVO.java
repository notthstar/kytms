package com.t28.forest.core.vo;

import java.util.Objects;

/**
 * @author XiangYuFeng
 * @description 分页信息页面展示对象
 * @create 2019/10/30
 * @since 1.0.0
 */
public class PageVO {
    /**
     * 当前页
     */
    private Integer current;
    /**
     * 每页显示的数据条数
     */
    private Integer size;
    /**
     * 总页数
     */
    private Integer total;

    public PageVO() {}

    public PageVO(Integer current, Integer size) {
        setCurrent(current);
        this.size = size;
    }

    public Integer getCurrent() {
        if (Objects.isNull(current)) {
            return 1;
        }
        return current;
    }

    /**
     * 获取开始列信息，mybatis的属性映射是通过getxxx方法进行匹配的
     * 所有可以直接在Mapper文件中#{start}方式引用
     * @return Integer
     */
    public Integer getStart() {
        return (getCurrent() - 1) * size;
    }

    public void setCurrent(Integer current) {
        if (current < 1) {
            this.current = 1;
            return;
        }
        this.current = current;
    }

    public Integer getSize() {
        return size;
    }

    public void setSize(Integer size) {
        this.size = size;
    }

    public Integer getTotal() {
        return total;
    }

    public void setTotal(Integer total) {
        this.total = total;
    }

    /**
     * 计算总页数的方法
     * @param count 数据总条数
     */
    public void calaTotalPage(int count) {
        int totalPage = count % getSize() == 0 ? count / getSize() : count / getSize() + 1;
        setTotal(totalPage);
    }

}