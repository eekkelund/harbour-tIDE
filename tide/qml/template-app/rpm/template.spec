
Name:       template


#%{!?qtc_qmake:%define qtc_qmake %qmake}
#%{!?qtc_qmake5:%define qtc_qmake5 %qmake5}
#%{!?qtc_make:%define qtc_make make}
#%{?qtc_builddir:%define _builddir %qtc_builddir}
Summary:    Sailfish OS Application
Version:    0.1
Release:    1
Group:      Qt/Qt
License:    LICENSE
URL:        http://example.org/
Source0:    %{name}-%{version}.tar.bz2
Requires:   sailfishsilica-qt5 >= 0.10.9
Requires:   pyotherside-qml-plugin-python3-qt5 >= 1.3, libsailfishapp-launcher
#BuildRequires:  pkgconfig(sailfishapp) >= 1.0.2
#BuildRequires:  pkgconfig(Qt5Core)
#BuildRequires:  pkgconfig(Qt5Qml)
#BuildRequires:  pkgconfig(Qt5Quick)
BuildRequires:  desktop-file-utils

%description
Application made with tIDE


%prep
%setup -q -n %{name}

%postun
    rm -rf /usr/share/%{name}
fi

%build

#%%qtc_qmake5 

#%%qtc_make %%{?_smp_mflags}


%install

rm -rf %{buildroot}
mkdir -p  %{buildroot}

mkdir -p %{buildroot}/usr/bin
mkdir -p %{buildroot}/usr/share/%{name}
mkdir -p %{buildroot}/usr/share/applications
mkdir -p %{buildroot}/usr/share/icons/hicolor/108x108/apps
mkdir -p %{buildroot}/usr/share/icons/hicolor/128x128/apps
mkdir -p %{buildroot}/usr/share/icons/hicolor/256x256/apps
mkdir -p %{buildroot}/usr/share/icons/hicolor/86x86/apps

cp -r {qml,translations} %{buildroot}/usr/share/%{name}
cp %{name}.desktop %{buildroot}/usr/share/applications
cp icons/108x108/* %{buildroot}/usr/share/icons/hicolor/108x108/apps
cp icons/128x128/* %{buildroot}/usr/share/icons/hicolor/128x128/apps
cp icons/256x256/* %{buildroot}/usr/share/icons/hicolor/256x256/apps
cp icons/86x86/* %{buildroot}/usr/share/icons/hicolor/86x86/apps


%clean
rm -rf %{buildroot}

#%%qmake5_install

#desktop-file-install --delete-original       \
#  --dir %{buildroot}%{_datadir}/applications             \
#   %{buildroot}%{_datadir}/applications/*.desktop

%files
%defattr(-,root,root,-)
%{_bindir}
%{_datadir}/%{name}
%{_datadir}/applications/%{name}.desktop
%{_datadir}/icons/hicolor/108x108/apps/%{name}.png
%{_datadir}/icons/hicolor/128x128/apps/%{name}.png
%{_datadir}/icons/hicolor/256x256/apps/%{name}.png
%{_datadir}/icons/hicolor/86x86/apps/%{name}.png
