From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 22 Oct 2015 22:57:10 +0300
Subject: [Intel-wired-lan] [patch] igbvf: integer overflow in
	igbvf_change_mtu()
In-Reply-To: <5628CE06.4070601@bfs.de>
References: <20151022091013.GC9202@mwanda>
 <5628CE06.4070601@bfs.de>
Message-ID: <20151022195710.GY7289@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Yeah, there is an integer overflow before we check but so far as I can
see it is harmless.  The kernel is full of harmless integer overflows.
I sort of feel like this is the simplest way to write it and the other
ways feel over engineered and unweildy.

Care to propose a patch, though?

regards,
dan carpenter

