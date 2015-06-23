From: Nicolai Stange <nicstange@gmail.com>
Date: Tue, 23 Jun 2015 11:58:18 +0200
Subject: [Intel-wired-lan] [jkirsher-net-queue:master 6/8]
	drivers/video/console/.tmp_vgacon.o:undefined reference to
	`screen_info'
In-Reply-To: <201506231244.VCo28rrK%fengguang.wu@intel.com> (kbuild test
 robot's message of "Tue, 23 Jun 2015 12:55:45 +0800")
References: <201506231244.VCo28rrK%fengguang.wu@intel.com>
Message-ID: <87twtyyced.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

kbuild test robot <fengguang.wu@intel.com> writes:
> drivers/video/console/.tmp_vgacon.o:(.text+0xf5254): undefined reference to `screen_info'

c.f.
https://lkml.kernel.org/r/87d20u5dji.fsf at gmail.com
  ("[PATCH] framebuffer: disable vgacon on microblaze arch")
