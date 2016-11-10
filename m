From: David Miller <davem@davemloft.net>
Date: Wed, 09 Nov 2016 21:20:25 -0500 (EST)
Subject: [Intel-wired-lan] [PATCH net-next 0/3] PHC frequency fine tuning
In-Reply-To: <cover.1478526333.git.richardcochran@gmail.com>
References: <cover.1478526333.git.richardcochran@gmail.com>
Message-ID: <20161109.212025.33151158831725274.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

From: Richard Cochran <richardcochran@gmail.com>
Date: Tue,  8 Nov 2016 22:49:15 +0100

> This series expands the PTP Hardware Clock subsystem by adding a
> method that passes the frequency tuning word to the the drivers
> without dropping the low order bits.  Keeping those bits is useful for
> drivers whose frequency resolution is higher than 1 ppb.

Series applied, thanks Richard.
