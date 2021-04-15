From: Nick Lowe <nick.lowe@gmail.com>
Date: Thu, 15 Apr 2021 13:17:24 +0100
Subject: [Intel-wired-lan] [PATCH net] igb: Fix XDP with PTP enabled
In-Reply-To: <20210415140438.60221f21@carbon>
References: <20210415092145.27322-1-kurt@linutronix.de>
 <20210415140438.60221f21@carbon>
Message-ID: <CADSoG1ssygE8XgkSoWW_WKf3Q43M6JGBN0fbUrrDfLsLyEy0=w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

> Doesn't the i210 card use the igc driver?
> This change is for igb driver.

The igb driver is used for the i210/i211, not igc.
