From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Mon, 13 Jun 2016 10:19:22 -0700
Subject: [Intel-wired-lan] patch for latest i40e driver kernel: stable
 4.1
In-Reply-To: <C2E5FB39-4FDD-4911-8096-BC2C1015908E@juniper.net>
References: <C2E5FB39-4FDD-4911-8096-BC2C1015908E@juniper.net>
Message-ID: <20160613101922.000034a2@unknown>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On Fri, 10 Jun 2016 22:25:34 +0000
Jawahar Balaji Thirumalaisamy <jawaharb@juniper.net> wrote:

> Is there a patch available to update stable-4.1 kernel with the latest i40e driver ?
> 
> I see that the i40e driver version available upstream is 1.3.2.

By definition the stable trees will not have any non-critical driver
updates.

You can always get our ?out of tree? driver from
https://sourceforge.net/projects/e1000/files/i40e%20stable/

Which should work fine on 4.1

