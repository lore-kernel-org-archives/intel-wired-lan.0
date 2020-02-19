From: David Miller <davem@davemloft.net>
Date: Wed, 19 Feb 2020 11:22:02 -0800 (PST)
Subject: [Intel-wired-lan] [PATCH net-next v2 0/13] net: core: add
 helper tcp_v6_gso_csum_prep
In-Reply-To: <fffc8b6d-68ed-7501-18f1-94cf548821fb@gmail.com>
References: <fffc8b6d-68ed-7501-18f1-94cf548821fb@gmail.com>
Message-ID: <20200219.112202.41545263500542131.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Heiner Kallweit <hkallweit1@gmail.com>
Date: Tue, 18 Feb 2020 20:55:18 +0100

> Several network drivers for chips that support TSO6 share the same code
> for preparing the TCP header, so let's factor it out to a helper.
> A difference is that some drivers reset the payload_len whilst others
> don't do this. This value is overwritten by TSO anyway, therefore
> the new helper resets it in general.

Series applied, thanks Heiner.
