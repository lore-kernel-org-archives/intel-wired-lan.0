From: David Miller <davem@davemloft.net>
Date: Thu, 19 May 2016 11:26:18 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH 1/1] net: i40e: avoid null pointer
	dereference
In-Reply-To: <1463517693-10333-1-git-send-email-xypron.glpk@gmx.de>
References: <1463517693-10333-1-git-send-email-xypron.glpk@gmx.de>
Message-ID: <20160519.112618.515295810053057625.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Date: Tue, 17 May 2016 22:41:33 +0200

> In function i40e_debug_aq parameter desc is assumed to be
> possibly NULL. Do not dereference it before checking the
> value.
> 
> Fixes: f905dd62be88 ("i40e/i40evf: add max buf len to aq debug print helper")
> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

I'll let Jeff pick this up.
