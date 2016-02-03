From: Stefan Assmann <sassmann@kpanic.de>
Date: Wed, 3 Feb 2016 09:13:45 +0100
Subject: [Intel-wired-lan] [PATCH net-next 6/6] e1000e: call ndo_stop()
 instead of dev_close() when running offline selftest
In-Reply-To: <20160202.162830.131864881309085395.davem@davemloft.net>
References: <1454408028-16986-1-git-send-email-sassmann@kpanic.de>
 <1454408028-16986-7-git-send-email-sassmann@kpanic.de>
 <56B0A843.9060703@kpanic.de>
 <20160202.162830.131864881309085395.davem@davemloft.net>
Message-ID: <56B1B6B9.7020905@kpanic.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 02.02.2016 22:28, David Miller wrote:
> 
> Always, when sending an updated version of a patch which is part of a
> series, always resubmit the entire series rather than just the patch
> which is changing.
> 
> Thanks.
> 

Sorry Dave, going to send out a complete V2 right away.

  Stefan
