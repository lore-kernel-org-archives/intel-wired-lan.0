From: Fengguang Wu <fengguang.wu@intel.com>
Date: Thu, 9 Nov 2017 15:43:15 +0800
Subject: [Intel-wired-lan] [vlan_device_event] BUG: unable to handle
 kernel paging request at 6b6b6ccf
In-Reply-To: <20171109065510.7x4iwuimqpe5ihsb@wfg-t540p.sh.intel.com>
References: <20171107102156.3fgxt6y6v5y2kqnf@wfg-t540p.sh.intel.com>
 <CA+55aFwqxZiN_XrZqvbtCsc8W=w895RaB1sjuVP1aTj8JStxzg@mail.gmail.com>
 <20171108094832.qxvkawpw2snpcbvh@wfg-t540p.sh.intel.com>
 <CA+55aFwK7935r325nmR-eQvanVCN3A+v3wEQHsW4NpSeBsybeA@mail.gmail.com>
 <20171108171230.ccf7lwutjysk26fc@wfg-t540p.sh.intel.com>
 <CAKgT0UfSTwTsQFP9ir=aOJDz-BvYONBd3Q6SOJWQherkQ8XpFQ@mail.gmail.com>
 <20171109031206.x6ta5ysdalf3lk3s@wfg-t540p.sh.intel.com>
 <CAM_iQpXJ1cqJKkp9X1-56gUi4V_s7Gbx_GPo=rgXzJ_LwY+v7w@mail.gmail.com>
 <20171109065510.7x4iwuimqpe5ihsb@wfg-t540p.sh.intel.com>
Message-ID: <20171109074315.fbm6heji62zbcdgp@wfg-t540p.sh.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Thu, Nov 09, 2017 at 02:55:10PM +0800, Fengguang Wu wrote:
>On Wed, Nov 08, 2017 at 10:34:10PM -0800, Cong Wang wrote:
>>On Wed, Nov 8, 2017 at 7:12 PM, Fengguang Wu <fengguang.wu@intel.com> wrote:
>>> Hi Alex,
>>>
>>>> So looking over the trace the panic seems to be happening after a
>>>> decnet interface is getting deleted. Is there any chance we could try
>>>> compiling the kernel without decnet support to see if that is the
>>>> source of these issues? I don't know if anyone on the Intel Wired Lan
>>>> team is testing with that enabled so if we can eliminate that as a
>>>> possible cause that would be useful.
>>>
>>>
>>> Sure and thank you for the suggestion!
>>>
>>> It looks disabling DECNET still triggers the vlan_device_event BUG.
>>> However when looking at the dmesgs, I find another warning just before
>>> the vlan_device_event BUG. Not sure if it's related one or independent
>>> now-fixed issue.
>>
>>Those decnet symbols are probably noises.
>
>Yes it's not related to CONFIG_DECNET.
>
>>How do you reproduce it? And what is your setup? Vlan device on
>>top of your eth0 (e1000)?
>
>It can basically be reproduced in one of our test machines --
>lkp-wsx03, which is a Westmere EX server.

Anyway if you'd like to try, here are the steps. It'll auto download
the images and run QEMU.

        apt-get install lib32gcc-7-dev # or lib32gcc-6-dev
        git clone https://github.com/intel/lkp-tests.git
        cd lkp-tests
        bin/lkp qemu -k <bzImage> job-script  # job-script is attached in this email

Note that even in our lkp-wsx03 machine, the chance of reproducing it
is only 3% (3 out of 100 boots).

Thanks,
Fengguang
-------------- next part --------------
#!/bin/sh

export_top_env()
{
	export suite='trinity'
	export testcase='trinity'
	export runtime=300
	export job_origin='/lkp/lkp/src/allot/rand/vm-lkp-wsx03-openwrt-i386/trinity.yaml'
	export testbox='vm-lkp-wsx03-openwrt-i386-5'
	export tbox_group='vm-lkp-wsx03-openwrt-i386'
	export kconfig='i386-randconfig-b0-11061302-CONFIG_DRM_BOCHS'
	export compiler='gcc-6'
	export queue='wfg'
	export branch='linus/master'
	export commit='c470abd4fde40ea6a0846a2beab642a578c0b8cd'
	export submit_id='5a03a4550b9a93f7c99708b0'
	export job_file='/lkp/scheduled/vm-lkp-wsx03-openwrt-i386-5/trinity-300s-openwrt-i386-2016-03-16.cgz-c470abd4fde40ea6a0846a2beab642a578c0b8cd-20171109-63433-kf9gj3-wait_kernel-0.yaml'
	export id='181954ca4367d475b88dc8de99b2d52ab533a5e1'
	export model='qemu-system-i386 -enable-kvm'
	export nr_vm=32
	export nr_cpu=1
	export memory='320M'
	export rootfs='openwrt-i386-2016-03-16.cgz'
	export hdd_partitions='/dev/vda'
	export swap_partitions='/dev/vdb'
	export need_kconfig='CONFIG_KVM_GUEST=y'
	export enqueue_time='2017-11-09 08:41:58 +0800'
	export _id='5a03a4560b9a93f7c99708bb'
	export _rt='/result/trinity/300s/vm-lkp-wsx03-openwrt-i386/openwrt-i386-2016-03-16.cgz/i386-randconfig-b0-11061302-CONFIG_DRM_BOCHS/gcc-6/c470abd4fde40ea6a0846a2beab642a578c0b8cd'
	export user='lkp'
	export result_root='/result/trinity/300s/vm-lkp-wsx03-openwrt-i386/openwrt-i386-2016-03-16.cgz/i386-randconfig-b0-11061302-CONFIG_DRM_BOCHS/gcc-6/c470abd4fde40ea6a0846a2beab642a578c0b8cd/0'
	export LKP_SERVER='inn'
	export max_uptime=1500
	export initrd='/osimage/openwrt/openwrt-i386-2016-03-16.cgz'
	export bootloader_append='root=/dev/ram0
user=lkp
job=/lkp/scheduled/vm-lkp-wsx03-openwrt-i386-5/trinity-300s-openwrt-i386-2016-03-16.cgz-c470abd4fde40ea6a0846a2beab642a578c0b8cd-20171109-63433-kf9gj3-wait_kernel-0.yaml
ARCH=i386
kconfig=i386-randconfig-b0-11061302-CONFIG_DRM_BOCHS
branch=linus/master
commit=c470abd4fde40ea6a0846a2beab642a578c0b8cd
BOOT_IMAGE=/pkg/linux/i386-randconfig-b0-11061302-CONFIG_DRM_BOCHS/gcc-6/c470abd4fde40ea6a0846a2beab642a578c0b8cd/vmlinuz-4.10.0
max_uptime=1500
RESULT_ROOT=/result/trinity/300s/vm-lkp-wsx03-openwrt-i386/openwrt-i386-2016-03-16.cgz/i386-randconfig-b0-11061302-CONFIG_DRM_BOCHS/gcc-6/c470abd4fde40ea6a0846a2beab642a578c0b8cd/0
LKP_SERVER=inn
debug
apic=debug
sysrq_always_enabled
rcupdate.rcu_cpu_stall_timeout=100
net.ifnames=0
printk.devkmsg=on
panic=-1
softlockup_panic=1
nmi_watchdog=panic
oops=panic
load_ramdisk=2
prompt_ramdisk=0
drbd.minor_count=8
systemd.log_level=err
ignore_loglevel
console=tty0
earlyprintk=ttyS0,115200
console=ttyS0,115200
vga=normal
rw'
	export lkp_initrd='/lkp/lkp/lkp-i386.cgz'
	export bm_initrd='/osimage/pkg/static/trinity-i386.cgz'
	export site='inn'
	export LKP_CGI_PORT=80
	export LKP_CIFS_PORT=139
	export vmlinux_file='/pkg/linux/i386-randconfig-b0-11061302-CONFIG_DRM_BOCHS/gcc-6/c470abd4fde40ea6a0846a2beab642a578c0b8cd/vmlinux'
	export kernel='/pkg/linux/i386-randconfig-b0-11061302-CONFIG_DRM_BOCHS/gcc-6/c470abd4fde40ea6a0846a2beab642a578c0b8cd/vmlinuz-4.10.0'
	export dequeue_time='2017-11-09 09:06:15 +0800'
	export job_initrd='/lkp/scheduled/vm-lkp-wsx03-openwrt-i386-5/trinity-300s-openwrt-i386-2016-03-16.cgz-c470abd4fde40ea6a0846a2beab642a578c0b8cd-20171109-63433-kf9gj3-wait_kernel-0.cgz'

	[ -n "$LKP_SRC" ] ||
	export LKP_SRC=/lkp/${user:-lkp}/src
}

run_job()
{
	echo $$ > $TMP/run-job.pid

	. $LKP_SRC/lib/http.sh
	. $LKP_SRC/lib/job.sh
	. $LKP_SRC/lib/env.sh

	export_top_env

	run_monitor $LKP_SRC/monitors/wrapper kmsg
	run_monitor $LKP_SRC/monitors/wrapper oom-killer
	run_monitor $LKP_SRC/monitors/plain/watchdog

	run_test $LKP_SRC/tests/wrapper trinity
}

extract_stats()
{
	$LKP_SRC/stats/wrapper kmsg

	$LKP_SRC/stats/wrapper time trinity.time
	$LKP_SRC/stats/wrapper time
	$LKP_SRC/stats/wrapper dmesg
	$LKP_SRC/stats/wrapper kmsg
	$LKP_SRC/stats/wrapper stderr
	$LKP_SRC/stats/wrapper last_state
}

"$@"
