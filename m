From: David Miller <davem@davemloft.net>
Date: Tue, 15 Sep 2020 15:37:28 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH net-next v2 00/10] make
 drivers/net/ethernet W=1 clean
In-Reply-To: <734f0c4595a18ab136263b6e5c97e7f48a93abe1.camel@kernel.org>
References: <a28498acdf87f11e81d3282d63f18dbe1a3d5329.camel@kernel.org>
 <20200915140326.GG3485708@lunn.ch>
 <734f0c4595a18ab136263b6e5c97e7f48a93abe1.camel@kernel.org>
Message-ID: <20200915.153728.107358987807075865.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Saeed Mahameed <saeed@kernel.org>
Date: Tue, 15 Sep 2020 13:03:03 -0700

> On Tue, 2020-09-15 at 16:03 +0200, Andrew Lunn wrote:
>> I would prefer we just enable W=1 by default for everything under
>> driver/net. Maybe there is something we can set in
>> driver/net/Makefile?
>> 
> 
> 
> Yes we can have our own gcc options in the Makfile regardless of what
> you put in W command line argument.

I definitely would like to see W=1 in drivers/net/Makefile eventually.
