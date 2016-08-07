From: Denis Turischev <denis.turischev@compulab.co.il>
Date: Sun, 7 Aug 2016 11:56:09 +0300
Subject: [Intel-wired-lan] e1000e: PHY cann't be initialized correctly
 on some I218 controllers
In-Reply-To: <1e8f37ec-eda4-eb2d-64d2-e96a7aa71902@intel.com>
References: <579F407E.9090602@compulab.co.il>
 <1e8f37ec-eda4-eb2d-64d2-e96a7aa71902@intel.com>
Message-ID: <57A6F7A9.1030401@compulab.co.il>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Hi Raanan,

On 08/04/2016 07:18 PM, Raanan Avargil wrote:
> It is hard to determine what is exactly the problem here and what causes the -3 error, but this is not the place to perform hw reset and retry to init the phy.

I agree that may be this is not the correct place for hw reset, can you advice about another solution?

It works, not only for me, for example it helps here:
http://www.linux.org.ru/forum/linux-hardware/10268216

Another fact that Windows drivers work fine with the same hw.

Denis
