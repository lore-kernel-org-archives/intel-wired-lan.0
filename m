From: zyjzyj2000@gmail.com <zyjzyj2000@gmail.com>
Date: Tue, 29 Dec 2015 10:32:04 +0800
Subject: [Intel-wired-lan] [PATCH V3] ixgbe: force to synchronize link_up
	and speed as a slave
In-Reply-To: <1450926752-11392-1-git-send-email-zyjzyj2000@gmail.com>
References: <1450926752-11392-1-git-send-email-zyjzyj2000@gmail.com>
Message-ID: <1451356326-2919-1-git-send-email-zyjzyj2000@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Hi, all

During the discussion with Emil, I think the time span between link_up 
and link_speed is not important when the X540 NIC acts as an independent 
interface. As such, a new patch is made to restrict synchronization 
between link_up and link_speed.

Any reply is appreciated.

Zhu Yanjun
