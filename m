From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Sat, 23 May 2020 20:20:37 +0800
Subject: [Intel-wired-lan] [e1000e] e86e383f28: suspend-stress.fail
In-Reply-To: <20200521052753.GB12456@shao2-debian>
References: <20200521052753.GB12456@shao2-debian>
Message-ID: <5A1631F8-259E-4897-BE52-0F5DB406E44F@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

[+Cc intel-wired-lan]

> On May 21, 2020, at 13:27, kernel test robot <rong.a.chen@intel.com> wrote:
> 
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-7):
> 
> commit: e86e383f2854234129c66e90f84ac2c74b2b1828 ("e1000e: Warn if disabling ULP failed")
> https://git.kernel.org/cgit/linux/kernel/git/jkirsher/next-queue.git dev-queue

kern  :warn  : [  240.884667] e1000e 0000:00:19.0 eth0: Failed to disable ULP
kern  :info  : [  241.896122] asix 2-3:1.0 eth1: link up, 100Mbps, full-duplex, lpa 0xC1E1
kern  :err   : [  242.269348] e1000e 0000:00:19.0 eth0: Hardware Error
kern  :info  : [  242.772702] e1000e 0000:00:19.0: pci_pm_resume+0x0/0x80 returned 0 after 2985422 usecs

So the patch does catch issues previously ignored.

I wonder what's the next move, maybe increase the ULP timeout again?

Kai-Heng

> 
> in testcase: suspend-stress
> with following parameters:
> 
> 	mode: mem
> 	iterations: 10
> 
> 
> 
> on test machine: 4 threads Broadwell with 8G memory
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>
> 
> SUSPEND RESUME TEST STARTED
> Suspend to mem 1/10:
> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-mem-debian-x86_64-20180403.cgz-e86e383f2854234129c66e90f84ac2c74b2b1828-20200517-66267-13fgkna-8.yaml&job_state=suspending-1/10 -O /dev/null
> Done
> Sleep for 10 seconds
> Suspend to mem 2/10:
> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-mem-debian-x86_64-20180403.cgz-e86e383f2854234129c66e90f84ac2c74b2b1828-20200517-66267-13fgkna-8.yaml&job_state=suspending-2/10 -O /dev/null
> Done
> Sleep for 10 seconds
> Suspend to mem 3/10:
> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-mem-debian-x86_64-20180403.cgz-e86e383f2854234129c66e90f84ac2c74b2b1828-20200517-66267-13fgkna-8.yaml&job_state=suspending-3/10 -O /dev/null
> Done
> Sleep for 10 seconds
> Suspend to mem 4/10:
> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-mem-debian-x86_64-20180403.cgz-e86e383f2854234129c66e90f84ac2c74b2b1828-20200517-66267-13fgkna-8.yaml&job_state=suspending-4/10 -O /dev/null
> Done
> Sleep for 10 seconds
> Suspend to mem 5/10:
> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-mem-debian-x86_64-20180403.cgz-e86e383f2854234129c66e90f84ac2c74b2b1828-20200517-66267-13fgkna-8.yaml&job_state=suspending-5/10 -O /dev/null
> Done
> Sleep for 10 seconds
> Suspend to mem 6/10:
> /usr/bin/wget -q --timeout=1800 --tries=1 --local-encoding=UTF-8 http://inn:80/~lkp/cgi-bin/lkp-jobfile-append-var?job_file=/lkp/jobs/scheduled/lkp-bdw-nuc1/suspend-stress-10-mem-debian-x86_64-20180403.cgz-e86e383f2854234129c66e90f84ac2c74b2b1828-20200517-66267-13fgkna-8.yaml&job_state=suspending-6/10 -O /dev/null
> Failed
> 
> 
> 
> To reproduce:
> 
>        git clone https://github.com/intel/lkp-tests.git
>        cd lkp-tests
>        bin/lkp install job.yaml  # job file is attached in this email
>        bin/lkp run     job.yaml
> 
> 
> 
> Thanks,
> Rong Chen
> 
> <config-5.7.0-rc4-01618-ge86e383f28542><job-script.txt><kmsg.xz><suspend-stress.txt><job.yaml>

