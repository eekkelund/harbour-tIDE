

Name:       harbour-tide

# >> macros
# << macros

%{!?qtc_qmake:%define qtc_qmake %qmake}
%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
%{!?qtc_make:%define qtc_make make}
%{?qtc_builddir:%define _builddir %qtc_builddir}
Summary:    transportable IDE
Version:    0.2.5
Release:    2
Group:      Qt/Qt
License:    GPLv3
URL:        https://github.com/eekkelund/harbour-tIDE
Source0:    %{name}-%{version}.tar.bz2
Requires:   sailfishsilica-qt5 >= 0.10.9, qtchooser, qt5-qtdeclarative-qmlscene, pyotherside-qml-plugin-python3-qt5 >= 1.3, rpm-build, meego-rpm-config
Requires:   qt5-qtdeclarative-import-folderlistmodel
# Requires: qt5-qmake, make, gcc-c++, qt5-qtgui-devel, qt5-qtcore-devel, libsailfishapp-devel
BuildRequires:  pkgconfig(sailfishapp) >= 1.0.2
BuildRequires:  pkgconfig(Qt5Core)
BuildRequires:  pkgconfig(Qt5Qml)
BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  desktop-file-utils

%description
transportable IDE for SailfishOS devices

%prep
%setup -q -n %{name}-%{version}

# >> setup
# << setup

%build
# >> build pre
# << build pre

%qtc_qmake5  \
    VERSION=%{version}

%qtc_make %{?_smp_mflags}

# >> build post
# << build post

%install
rm -rf %{buildroot}
# >> install pre
# << install pre
%qmake5_install

# >> install post
# << install post

desktop-file-install --delete-original       \
  --dir %{buildroot}%{_datadir}/applications             \
   %{buildroot}%{_datadir}/applications/*.desktop

#So dirty..........
%post
systemctl-user restart maliit-server.service
install -g nemo -o nemo -d /home/nemo/tIDE/
mv /home/nemo/Projects/ /home/nemo/tIDE/
chown -R nemo:nemo /home/nemo/tIDE/

%postun
rm -rf %{_datadir}/%{name}/qml/pages/Editor2.qml

%files
%defattr(4755,root,root,4755)
%{_bindir}/harbour-tide-root
%defattr(755,nemo,nemo,755)
%{_localstatedir}/lib/harbour-tide-keyboard/config/
%{_localstatedir}/lib/harbour-tide-keyboard/database/
%defattr(-,root,root,-)
%{_bindir}/%{name}/
%{_datadir}/%{name}/
%{_datadir}/applications/%{name}.desktop
%{_datadir}/applications/harbour-tide-root.desktop
%{_datadir}/icons/hicolor/*/apps/%{name}.png
%{_datadir}/icons/hicolor/*/apps/%{name}-root.png
%{_libdir}
%{_datadir}/maliit/plugins/com/jolla/layouts/
%{_datadir}/maliit/plugins/com/jolla/tide/
# >> files
# << files
