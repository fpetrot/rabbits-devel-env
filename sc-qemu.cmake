include(ExternalProject)

find_package(PythonInterp 2.4 REQUIRED)

set(SC_QEMU_TARGETS arm-softmmu)
set(SC_QEMU_CONF_ARGS 
	--disable-debug-tcg
	--disable-sparse
	--disable-sdl
	--disable-gtk
	--disable-vnc
	--disable-xen
	--disable-brlapi
	--disable-vnc-sasl
	--disable-vnc-jpeg
	--disable-vnc-png
	--disable-curses
	--disable-curl
	--disable-bluez
	--disable-slirp
	--disable-kvm
	--disable-user
	--disable-linux-user
	--disable-bsd-user
	--disable-pie
	--disable-linux-aio
	--disable-attr
	--disable-blobs
	--disable-docs
	--disable-vhost-net
	--disable-spice
	--disable-usb-redir
	--disable-guest-agent
	--disable-cap-ng
	--disable-libiscsi
	--disable-libusb
	--disable-tools
    --disable-nettle
    --disable-virglrenderer
    --disable-opengl
    --disable-vde
	--audio-drv-list=
	--disable-werror
	--python=${PYTHON_EXECUTABLE}
)

set(SC_QEMU_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/sc-qemu CACHE INTERNAL "sc-qemu include directory" FORCE)
set(SC_QEMU_LIBRARIES ${CMAKE_CURRENT_SOURCE_DIR}/sc-qemu/arm-softmmu/libqemu-system-arm.so CACHE INTERNAL "sc-qemu libraries" FORCE)

if (NOT RABBITS_SC_QEMU_DISABLE_BUILD)
	# The BUILD_ALWAYS argument was introduced in version 3.1
	if("${CMAKE_VERSION}" VERSION_LESS 3.1)
		set(build_always)
	else()
		set(build_always BUILD_ALWAYS 1)
	endif()

	ExternalProject_Add(sc-qemu
		SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/sc-qemu
		CONFIGURE_COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/sc-qemu/configure
			--enable-rabbits
			--target-list=${SC_QEMU_TARGETS}
			${SC_QEMU_CONF_ARGS}
		BUILD_COMMAND ${MAKE}
		${build_always}
		INSTALL_COMMAND ""
	)
endif()
