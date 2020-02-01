//
//  ViewController.swift
//  FunQuizzes
//
//  Created by Thiện Tùng on 2/1/20.
//  Copyright © 2020 tung. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionNumber: UILabel!
    
    @IBOutlet weak var question: UILabel!
    
    @IBOutlet weak var dapAnA: UILabel!
    
    @IBOutlet weak var dapAnB: UILabel!
    
    @IBOutlet weak var dapAnC: UILabel!
    
    @IBOutlet weak var ketQua: UILabel!
    
    @IBOutlet weak var cauTraLoi: UISegmentedControl!
    
    var diem: Int = 0
    
    var cauHoiDangLam = 0
    
    var questions: [String] = []
    
    var cacCauTraLoi: [String] = []
    
    var ketQuaDung: [Int] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupData()
        questionNumber.text = "Câu hỏi số: \(cauHoiDangLam + 1)"
        question.text = questions[cauHoiDangLam]
        
        var cacDapAn: [String] = cacCauTraLoi[cauHoiDangLam
        ].components(separatedBy: "-")
        dapAnA.text = "Đáp án A: " + cacDapAn[0]
        dapAnB.text = "Đáp án B: " + cacDapAn[1]
        dapAnC.text = "Đáp án C: " + cacDapAn[2]
        
    }
    
    func setupData() {
        questions = ["Tablet của hãng nào sau đây thống trị dòng tablet 10 năm qua ? ",
                     "Hiện nay iPhone và iPad có chạy chung hệ điều hành không ?",
                     "Microsoft đã làm ra hệ điều hành nào sau đây ?",
                     "Kiểu dữ liệu nào chỉ có thể lưu trữ các giá trị được xác định trước ?",
                     "Điều nào sau đây mô tả đúng nhất về thanh ghi (register) CPU ?",
                     "Có bao nhiêu Megabyte trong một Gigabyte ?"]
        cacCauTraLoi = ["Apple-Samsung-Huawei",
                        "Có-Không-Tuỳ dòng máy",
                        "Window-MacOS-Linux",
                        "Integer-String-Enum",
                        "Vùng lưu trữ tạm thời của CPU-Cầu nối CPU và GPU-Kết nối RAM với CPU",
                        "1000-1024-1032"]
        ketQuaDung = [0, 1, 0, 2, 0, 1]
        
    }
    
    
    @IBAction func cauTraLoi(_ sender: Any) {
        var dapAnDuocChon = cauTraLoi.selectedSegmentIndex
        var dapAnChinhThuc = ketQuaDung[cauHoiDangLam]
        if dapAnDuocChon == dapAnChinhThuc {
            diem -= -10
        }
    }
    
    @IBAction func nextQuestion(_ sender: Any) {
        if cauHoiDangLam == 5 {
            ketQua.text = "Điểm của bạn là: \(diem)"
            
        } else {
            cauHoiDangLam -= -1
            questionNumber.text = "Câu hỏi số: \(cauHoiDangLam + 1)"
            question.text = questions[cauHoiDangLam]
            
            var cacDapAn: [String] = cacCauTraLoi[cauHoiDangLam
            ].components(separatedBy: "-")
            dapAnA.text = "Đáp án A: " + cacDapAn[0]
            dapAnB.text = "Đáp án B: " + cacDapAn[1]
            dapAnC.text = "Đáp án C: " + cacDapAn[2]
        }
    }
    
}

