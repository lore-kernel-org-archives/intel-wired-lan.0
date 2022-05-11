From: Piotr Skajewski <piotrx.skajewski@intel.com>
Date: Wed, 11 May 2022 10:32:15 +0200
Subject: [Intel-wired-lan] [PATCH v2 1/1] ixgbe: correct SDP0 check of SFP
 cage for X550
In-Reply-To: <20220425131758.4749-1-jeffd@silicom-usa.com>
References: <20220425131758.4749-1-jeffd@silicom-usa.com>
Message-ID: <20220511083215.9833-1-piotrx.skajewski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Jeff,

Our analysis (using 0x15c4) showed that every time the cage is empty SDP
indicates 0 and when cage is full it indicates 1. No matter what
transceiver we used, from those we have. The same happens even we don't
use the device which fall into crosstalk fix e.g 0x15c2.

When proposed patch was applied, the devices are no longer able to
negotiate speed. So basically this patch should not be accepted.

NACK

BR,
Piotr
