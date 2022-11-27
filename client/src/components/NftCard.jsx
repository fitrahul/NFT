import React from "react";
import nftStyles from "../../styles/Home.module.css";

const NftCard = ({ nftObj }) => {
//   console.log("rahul: ", nftObj.attributes);
  return (
    <>
      <div className={nftStyles.parentDiv}>
        <div className={nftStyles.name}>
          NAME: <div style={{ color: "#000", paddingLeft: "5px" }}>{nftObj.name}</div>
        </div>
        <div className={nftStyles.image}>
          <img className={nftStyles.imgChild} src={nftObj.image} alt="" />
        </div>
        <div className={nftStyles.description}>{nftObj.description}</div>
        <div className={nftStyles.attributes}>
          <div className={nftStyles.attributes1}>Trait Type</div>
          <div className={nftStyles.attributes1}>Value</div>
          <div className={nftStyles.attributes1}>Max Value</div>
        </div>
        {nftObj?.attributes?.map((el) => (
          <div className={nftStyles.attributes}>
            <div className={nftStyles.attributes2}>{el.trait_type}</div>
            <div className={nftStyles.attributes2}>{el.value}</div>
            <div className={nftStyles.attributes2}>{el.max_value}</div>
          </div>
        ))}
      </div>
    </>
  );
};

export default NftCard;
