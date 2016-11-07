From: Ray Bellis <ray@isc.org>
Date: Mon, 7 Nov 2016 16:47:54 +0000
Subject: [Intel-wired-lan] i40e performance regression after 1.3.9 ?
Message-ID: <9f9f62ec-fbce-534a-d2bd-e918a03a3899@isc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Does anyone have any ideas on the performance regression I've reported
on the i40e at https://sourceforge.net/p/e1000/bugs/544/ ?

I've got code that with the 1.3.9 driver and kernel 4.3 can achieve 1.3
million packets per second, but if I drop in 1.3.38 or later it drops to
about 500k.

This regression affects off-the-shelf DNS server software packages too.

thanks,

Ray Bellis
ISC Research Fellow

