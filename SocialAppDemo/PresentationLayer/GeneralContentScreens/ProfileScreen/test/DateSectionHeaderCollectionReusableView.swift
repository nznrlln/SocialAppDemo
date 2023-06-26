//
//  DateSectionHeaderCollectionReusableView.swift
//  SocialAppDemo
//
//  Created by Нияз Нуруллин on 26.06.2023.
//

import UIKit

class DateSectionHeaderCollectionReusableView: UICollectionReusableView {

    private let dateLabel: UILabel = {
        let label = UILabel()
        label.toAutoLayout()
        label.font = Fonts.interReg14
        label.textColor = Palette.secondaryText
        label.text = "date"

        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = .systemBackground
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.centerX.centerY.equalToSuperview()
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupHeader(model: String?) {
        guard let model = model else { return }

        self.dateLabel.text = model
    }

     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
         createLines()
         createRoundedRect()

     }

    private func createLines() {
        let y: CGFloat = self.frame.height / 2
        let firstStartX: CGFloat = 16
        let firstEndX: CGFloat = self.frame.width / 2 - 50 - 10

        let secondStartX: CGFloat = self.frame.width / 2 + 50 + 10
        let secondEndX: CGFloat = self.frame.width - 16

        let path = UIBezierPath()
        path.move(to: CGPoint(x: firstStartX, y: y))
        path.addLine(to: CGPoint(x: firstEndX, y: y))

        path.move(to: CGPoint(x: secondStartX, y: y))
        path.addLine(to: CGPoint(x: secondEndX, y: y))

        Palette.secondaryText.setStroke()
        path.lineWidth = 1
        path.stroke()
    }

    private func createRoundedRect() {
        let rectHeight: CGFloat = 24
        let rectWidth: CGFloat = 100
        let cornerRadius: CGFloat = 10
        let rectRect = CGRect(x: self.frame.width / 2 - rectWidth / 2,
                              y: 1,
                              width: rectWidth,
                              height: rectHeight)

        let path = UIBezierPath(roundedRect: rectRect, cornerRadius: cornerRadius)

        Palette.secondaryText.setStroke()
        path.lineWidth = 1
        path.stroke()
    }

}
