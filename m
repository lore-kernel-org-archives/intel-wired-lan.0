From: Jesse Brandeburg <jesse.brandeburg@intel.com>
Date: Wed, 17 Mar 2021 09:41:37 -0700
Subject: [Intel-wired-lan] [net-next PATCH v2 00/10] ethtool: Factor out
 common code related to writing ethtool strings
In-Reply-To: <161594093708.5644.11391417312031401152.stgit@localhost.localdomain>
References: <161594093708.5644.11391417312031401152.stgit@localhost.localdomain>
Message-ID: <20210317094137.00007073@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: intel-wired-lan@osuosl.org
List-ID: <intel-wired-lan.osuosl.org>

Alexander Duyck wrote:

> This patch set is meant to be a cleanup and refactoring of common code bits
> from several drivers. Specificlly a number of drivers engage in a pattern
> where they will use some variant on an sprintf or memcpy to write a string
> into the ethtool string array and then they will increment their pointer by
> ETH_GSTRING_LEN.
> 
> Instead of having each driver implement this independently I am refactoring
> the code so that we have one central function, ethtool_sprintf that does
> all this and takes a double pointer to access the data, a formatted string
> to print, and the variable arguments that are associated with the string.
> 
> Changes from v1:
> Fixed usage of char ** vs  unsigned char ** in hisilicon drivers
> 
> Changes from RFC:
> Renamed ethtool_gsprintf to ethtool_sprintf
> Fixed reverse xmas tree issue in patch 2
> 

Thanks Alex, I had a look over the whole thing and it looks good to me.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
