From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 23 Oct 2015 11:16:59 +0300
Subject: [Intel-wired-lan] [patch] igbvf: integer overflow in
	igbvf_change_mtu()
In-Reply-To: <20151022091013.GC9202@mwanda>
References: <20151022091013.GC9202@mwanda>
Message-ID: <20151023081659.GB7289@mwanda>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Oh...  Hm.  I was a bit confused by what Walter was saying.  But there
already is an integer overflow check here so it can't actually be
negative...  I added it a couple years ago.

Forget about this patch.  Sorry.

regards,
dan carpenter

