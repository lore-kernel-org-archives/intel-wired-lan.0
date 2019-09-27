From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Date: Fri, 27 Sep 2019 19:22:52 +0300
Subject: [Intel-wired-lan] [net-next v3 7/7] renesas: reject unsupported
 external timestamp flags
In-Reply-To: <20190926181109.4871-8-jacob.e.keller@intel.com>
References: <20190926181109.4871-1-jacob.e.keller@intel.com>
 <20190926181109.4871-8-jacob.e.keller@intel.com>
Message-ID: <a08e6e28-bc98-a103-0577-a0bb45f950d5@cogentembedded.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

On 09/26/2019 09:11 PM, Jacob Keller wrote:

> Fix the renesas PTP support to explicitly reject any future flags that
> get added to the external timestamp request ioctl.
> 
> In order to maintain currently functioning code, this patch accepts all
> three current flags. This is because the PTP_RISING_EDGE and
> PTP_FALLING_EDGE flags have unclear semantics and each driver seems to
> have interpreted them slightly differently.
> 
> Cc: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

[...]

MBR, Sergei
