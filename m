From: David Miller <davem@davemloft.net>
Date: Tue, 02 Feb 2016 16:28:30 -0500 (EST)
Subject: [Intel-wired-lan] [PATCH net-next 6/6] e1000e: call ndo_stop()
 instead of dev_close() when running offline selftest
In-Reply-To: <56B0A843.9060703@kpanic.de>
References: <1454408028-16986-1-git-send-email-sassmann@kpanic.de>
 <1454408028-16986-7-git-send-email-sassmann@kpanic.de>
 <56B0A843.9060703@kpanic.de>
Message-ID: <20160202.162830.131864881309085395.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>


Always, when sending an updated version of a patch which is part of a
series, always resubmit the entire series rather than just the patch
which is changing.

Thanks.
