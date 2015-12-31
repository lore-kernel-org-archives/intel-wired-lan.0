From: zyjzyj2000@gmail.com <zyjzyj2000@gmail.com>
Date: Thu, 31 Dec 2015 15:11:38 +0800
Subject: [Intel-wired-lan] [PATCH V6] ixgbe: synchronize link_up and
	link_speed of a slave
In-Reply-To: <1451540268.3348.108.camel@intel.com>
References: <1451540268.3348.108.camel@intel.com>
Message-ID: <1451545899-16584-1-git-send-email-zyjzyj2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Hi, all

Thanks for the reply from Jeff.

V2: Based on feedback from Jeff Kirsher, it is not appropriate to continue
    in the function ixgbe_watchdog_link_is_up without link_speed since this will
    make some virtual NICs not work well.

V3: Based on feedback from Emil Tantilov, the time span between link_up 
    and link_speed is not important when the X540 NIC acts as an independent 
    interface. 

V4: According to Rustad, Mark D, maybe it is related with copper phy. To make
    fiber phy more robust, synchronize both the link_up and link_speed of a slave
    interface in ixgbe driver.

V5: Based on feedback from Rustad, Mark D, simplify code comment and if statement 
    to only test for IFF_SLAVE flag and unknown link speed.

V6: Based on feedback from Jeff Kirsher, the patch format is adjusted 
    and change log of this patch are added.

Best Regards!
Zhu Yanjun
