# DayDart

A new Flutter package project.

![https://img.shields.io/github/license/csjiabin/daydart.svg](https://img.shields.io/github/license/csjiabin/daydar.svg)
![https://img.shields.io/github/issues/csjiabin/daydart.svg](https://img.shields.io/github/issues/csjiabin/daydar.svg)

## Getting Started

This project is a starting point for a Dart
[package](https://flutter.io/developing-packages/),
a library module containing code that can be shared easily across
multiple Flutter or Dart projects.

For help getting started with Flutter, view our
[online documentation](https://flutter.io/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## API

`DayDart` 对象是不可变的，所有的调用都将返回一个新的 `DayDart` 对象。

- [解析](#解析)
  - [当前时间](#当前时间)
  - [原生创建](#原生创建)
  - [时间字符串](#时间字符串)
  - [DateTime 对象](#DateTime-对象)
  - [复制](#复制)
  - [验证](#验证)
- [获取](#获取)
  - [年](#年)
  - [月](#月)
  - [日](#日)
  - [星期](#星期)
  - [时](#时)
  - [分](#分)
  - [秒](#秒)
  - [毫秒](#毫秒)
- [操作](#操作)
  - [增加](#增加)
  - [减少](#减少)
- [查询](#查询)
  - [是否相等](#是否相等)
  - [是否之前](#是否之前)
  - [是否之后](#是否之后)
  - [判断是否为 DayDart](判断是否为-DayDart)
- [显示](#显示)
  - [格式化](#格式化)
  - [DateTime 对象](#DateTime-对象)
  - [ISO 8601 字符串](#ISO-8601-字符串)
  - [List](#List)
  - [Map](#Map)
  - [字符串](#字符串)

----