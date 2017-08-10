//
//  RefundPolicyViewController.swift
//  Crusia
//
//  Created by Hyoungsu Ham on 2017. 8. 6..
//  Copyright © 2017년 Hyoungsu Ham. All rights reserved.
//

import UIKit

class RefundPolicyViewController: UIViewController {

    @IBOutlet weak var refundInfoLabel: UILabel!
    
    // 스테이더스 바 숨기기
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refundInfoLabel.text = "체크인 30일 전까지 예약을 취소하는 경우 모든 수수료를 포함한 숙박 요금을 전액 환불 받을 수 있습니다. \n\n체크인 당일 오후 12시까지 취소하면 총 숙박 요금의 50%가 환불됩니다. 모든 수수료는 전액 환불됩니다. \n\n 숙박 중 예약을 취소하면 일부 환불을 요청할 수 있습니다. \n\n숙박 기간 중 현지 시각으로 오후 12시 이전에 취소하시면 수수료를 제외한 잔여 예약 대금의 50%가 환불됩니다.\n\n숙박 기간 중 현지 시각으로 오후 12시 이후에 취소하시면 취소 당일 숙박 요금 및 수수료를 제외한 잔여 예약 대금의 50% 금액이 환불됩니다. \n\n체크인 전에 예약을 취소하면 청소비는 언제나 환불됩니다. \n\n게스트가 체크인 전 예약을 취소하는 경우 1년에 최대 3회까지 에어비앤비 서비스 수수료가 환불됩니다. 환불자격은 예약 시점을 기준으로 이전 취소 횟수와 예정된 예약 중 수수료 환불이 가능한 예약을 기준으로 결정됩니다. 한편 게스트가 기존 예약과 겹치는 날짜에 다른 예약을 하면 추후 취소해도 에어비앤비 서비스 수수료가 환불되지 않습니다. \n\n다음과 같은 경우 숙박비(청구한 총 숙박 요금)를 환불 받을 수 있습니다. \n\n당사자들로부터 불만 사항이 있는 경우, 체크인 24시간 이내에 에어비앤비에 알려야 합니다. \n\n 분쟁 발생 시 에어비앤비는 중재를 위해 개입할 수 있으며, 이 경우 에어비앤비가 최종 결정을 내리게 됩니다. \n\n예약 취소 확인 화면에서 예약 취소 버튼을 클릭해야 예약이 정식으로 취소됩니다. 예약 취소 확인 페이지로 이동하려면 알림판 > 여행 목록 > 예약 변경 또는 취소를 클릭하시기 바랍니다. \n\n게스트 환불 정책, 정상참작이 가능한 상황, 또는 서비스 약관에서 허용하는 기타 사유로 에어비앤비가 예약을 취소하는 경우, 숙소의 환불 정책 대신 관련 정책이 적용될 수 있습니다. 예외 사항을 확인해 보세요. \n\n관련 세금액은 차감 및 징수됩니다."
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func dismissButtonTouched(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
