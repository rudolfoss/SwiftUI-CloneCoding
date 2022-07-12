//
//  ThemePicker.swift
//  Scrumdinger
//
//  Created by HA on 2022/07/11.
//

import SwiftUI

struct ThemePicker: View {
    @Binding var selection: Theme
    var body: some View {
        Picker("Theme", selection: $selection){
            ForEach(Theme.allCases){theme in
                //선택기 및 목록과 같은 컨트롤에서 하위 보기를 구분해야 하는 경우 하위 보기에 태그를 지정할 수 있음.
                ThemeView(theme: theme)
                    .tag(theme)
            }
        }
    }
}

struct ThemePicker_Previews: PreviewProvider {
    static var previews: some View {
        //the theme picker requires a binding.
        //constant(_:)type 메서드를 사용하여 하드 코딩된 변경할 수 없는 값에 대한 바인딩을 만들 수 있음 . 상수 바인딩은 미리보기나 앱 UI 프로토타이핑 시 유용.
        ThemePicker(selection: . constant(.periwinkle))
    }
}
