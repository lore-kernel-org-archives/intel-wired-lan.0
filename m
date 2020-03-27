From: David Miller <davem@davemloft.net>
Date: Thu, 26 Mar 2020 19:31:40 -0700 (PDT)
Subject: [Intel-wired-lan] [PATCH 1/2] igb: convert to use
 i2c_new_client_device()
In-Reply-To: <20200326211001.13171-2-wsa+renesas@sang-engineering.com>
References: <20200326211001.13171-1-wsa+renesas@sang-engineering.com>
 <20200326211001.13171-2-wsa+renesas@sang-engineering.com>
Message-ID: <20200326.193140.518355155914627267.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Thu, 26 Mar 2020 22:09:59 +0100

> Move away from the deprecated API and return the shiny new ERRPTR where
> useful.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied.
